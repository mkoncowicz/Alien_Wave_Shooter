extends Entity

@onready var nav_agent = $NavigationAgent2D

func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * 60
	
	velocity = new_velocity
	move_and_slide()

func update_target_location(target_location):
	nav_agent.target_position = target_location


func _on_navigation_agent_2d_target_reached():
	#attack here
	print("attack")



func _on_hitbox_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(30)
