extends Area2D

@export var health_value : int = 25 
func _ready(): 
	$AnimatedSprite2D.play("default")

func _on_AidKit_body_entered(body):
	if body.has_method("heal"):
		body.heal(health_value)
		queue_free()
