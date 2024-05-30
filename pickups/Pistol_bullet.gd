extends Area2D

func _ready(): 
	$AnimatedSprite2D.play("default")

func _on_Pistol_bullet_body_entered(body):
	
