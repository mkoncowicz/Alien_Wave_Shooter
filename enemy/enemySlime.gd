extends Entity

#var speed override how to do 
var player_chase = false
var player = null

func _physics_process(delta):
	if player_chase:
		position += (player.position - position)/speed
		
		$AnimatedSprite2D.play("move")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	



func _on_detect_radius_body_entered(body):
	player = body
	player_chase = true

func _on_detect_radius_body_exited(body):
	player = null
	player_chase = false