extends Area2D

func _ready(): 
	$AnimatedSprite2D.play("default")

func _on_Shotgun_bullet_body_entered(body):
	pass # Replace with function body.
