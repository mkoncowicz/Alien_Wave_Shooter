extends Entity

@export var bullet: PackedScene = preload("res://bullets/Alien_gun_bullet.tscn")
@onready var nav_agent = $NavigationAgent2D
@onready var detection_area = $DetectionArea2D
@onready var weapon = $Gun
@onready var muzzle = $Gun/Gun_muzzle
@onready var fire_speed = $Fire_speed
@onready var fire_animation = $Fire_animation
@onready var flash_position = $Gun/Gun_flash
var is_dead = false
var is_hit = false
var is_shooting = false
var target_location = Vector2.ZERO

func _physics_process(delta):
	if is_dead or is_hit:
		return
	
	fire_animation.global_position = flash_position.global_position
	
	weapon.look_at(nav_agent.target_position)
	if nav_agent.target_position.x < global_position.x:
		weapon.flip_v = true
	else:
		weapon.flip_v = false
	
	if is_shooting:
		animated_sprite.play("idle")
		if fire_speed.is_stopped():
			shoot()
	else:
		animated_sprite.play("run")
		
		var current_location = global_transform.origin
		var next_location = nav_agent.get_next_path_position()
		var new_velocity = (next_location - current_location).normalized() * 80
		
		velocity = new_velocity
		move_and_slide()
			
		if nav_agent.target_position.x < global_position.x:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false

func update_target_location(target_location):
	if is_dead or is_hit:
		return
	self.target_location = target_location
	nav_agent.target_position = target_location

func take_damage(damage: int):
	self.hp -= damage
	if self.hp <= 0:
		die()
	else:
		play_hit_animation()

func die():
	if is_dead:
		return
	
	is_dead = true
	animated_sprite.play("death")
	$CollisionShape2D.set_deferred("disabled", true) 
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true) 
	$Hitbox/CollisionShape2D.set_deferred("disabled", true) 
	$PointLight2D.set_deferred("enabled", false)
	await get_tree().create_timer(1.0).timeout 
	queue_free()

func play_hit_animation():
	is_hit = true
	animated_sprite.play("hit")
	$CollisionShape2D.set_deferred("disabled", true) 
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true) 
	$Hitbox/CollisionShape2D.set_deferred("disabled", true) 
	await get_tree().create_timer(0.5).timeout 
	is_hit = false
	$CollisionShape2D.set_deferred("disabled", false) 
	$Hurtbox/CollisionShape2D.set_deferred("disabled", false) 
	$Hitbox/CollisionShape2D.set_deferred("disabled", false) 

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
	var bullet_instance = bullet.instantiate()
	get_tree().current_scene.add_child(bullet_instance)
	bullet_instance.global_position = muzzle.global_position
	bullet_instance.rotation_degrees = weapon.rotation_degrees
	fire_animation.add_fire_animation("alien_gun")
	fire_speed.start()
	
