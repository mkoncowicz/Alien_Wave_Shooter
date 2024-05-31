extends Area2D

@export var health_value : int = 20 

func _ready(): 
	$AnimatedSprite2D.play("default")

func _on_AidKit_body_entered(body):
	if body.has_method("heal"):
		body.heal(health_value)
		self.hide()
		$AnimatedSprite2D/Pickup_aid.play()
		await get_tree().create_timer(0.3).timeout
		queue_free()
