extends Entity
@onready var map = find_parent("Map")
@onready var gui = map.find_child("Player").find_child("GUI")
@export var bullet: PackedScene = preload("res://bullets/Boss_bullet.tscn")
@onready var nav_agent = $NavigationAgent2D
@onready var detection_area = $DetectionArea2D
@onready var muzzle1 = $Muzzle1
@onready var muzzle2 = $Muzzle2
@onready var muzzle3 = $Muzzle3
@onready var fire_speed = $Fire_speed
@onready var fire_animation = $Fire_animation
@onready var flash_position = $AnimatedSprite2D/Flash
var is_dead = false
var is_shooting = false
var target_location = Vector2.ZERO

func _ready():
	hp = 3000
	Globals.boss_health = hp
	$GPUParticles2D.set_deferred("emitting", true) 
	await get_tree().create_timer(2).timeout

func _physics_process(delta):
	$Boss_progres_bar.update()
	Globals.boss_health = hp
	if is_dead:
		return
	muzzle1.look_at(nav_agent.target_position)
	muzzle2.look_at(nav_agent.target_position)
	muzzle3.look_at(nav_agent.target_position)
	
	fire_animation.global_position = flash_position.global_position
	animated_sprite.play("move")

	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * 60
	
	velocity = new_velocity
	move_and_slide()
	
	if nav_agent.target_position.x < global_position.x:
		animated_sprite.flip_h = true
		flash_position.set_position(Vector2(-8, -14))
		muzzle1.set_position(Vector2(-8, -14))
		muzzle2.set_position(Vector2(-8, -14))
		muzzle3.set_position(Vector2(-8, -14))
	else:
		animated_sprite.flip_h = false
		flash_position.set_position(Vector2(8, -14))
		muzzle1.set_position(Vector2(8, -14))
		muzzle2.set_position(Vector2(8, -14))
		muzzle3.set_position(Vector2(8, -14))
	
	if is_shooting:
		if fire_speed.is_stopped():
			shoot()

func update_target_location(target_location):
	if is_dead:
		return
	self.target_location = target_location
	nav_agent.target_position = target_location

func take_damage(damage: int):
	self.hp -= damage
	if self.hp <= 0:
		die()

func die():
	if is_dead:
		return
	update_score()
	get_tree().call_group("level", "set_boss_is_dead")
	get_tree().call_group("level", "enemy_death")
	is_dead = true
	animated_sprite.play("death")
	$CollisionShape2D.set_deferred("disabled", true) 
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true) 
	$Hitbox/CollisionShape2D.set_deferred("disabled", true) 
	$PointLight2D.set_deferred("enabled", false)
	await get_tree().create_timer(1.0).timeout 
	queue_free()

func _on_hitbox_body_entered(body):
	if body.has_method("player_take_damage"):
		body.player_take_damage(30)

func _on_detection_area_body_entered(body):
	if body.name == "Player":
		is_shooting = true

func _on_detection_area_body_exited(body):
	if body.name == "Player":
		is_shooting = false

func shoot():
	var bullet_instance1 = bullet.instantiate()
	get_tree().current_scene.add_child(bullet_instance1)
	bullet_instance1.global_position = muzzle1.global_position
	bullet_instance1.rotation_degrees = muzzle1.rotation_degrees
	
	var bullet_instance2 = bullet.instantiate()
	get_tree().current_scene.add_child(bullet_instance2)
	bullet_instance2.global_position = muzzle2.global_position
	bullet_instance2.rotation_degrees = muzzle1.rotation_degrees - 8
	
	var bullet_instance3 = bullet.instantiate()
	get_tree().current_scene.add_child(bullet_instance3)
	bullet_instance3.global_position = muzzle3.global_position
	bullet_instance3.rotation_degrees = muzzle1.rotation_degrees + 8
	fire_animation.add_fire_animation("boss_gun")
	fire_speed.start()

func update_score():
	Globals.score += 999999
	gui.update_score()
