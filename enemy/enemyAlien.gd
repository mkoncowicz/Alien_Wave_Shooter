extends Entity

@onready var nav_agent = $NavigationAgent2D
var is_dead = false
var is_hit = false

func _physics_process(delta):
	if is_dead or is_hit:
		return
		
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
	nav_agent.target_position = target_location

func _on_hitbox_body_entered(body):
	if body.has_method("player_take_damage"):
		body.player_take_damage(30)

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
	$PointLight2D2.set_deferred("enabled", false)
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
