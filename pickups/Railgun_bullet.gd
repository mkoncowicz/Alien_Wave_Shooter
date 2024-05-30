extends Area2D

func _ready(): 
	$AnimatedSprite2D.play("default")

func _on_Railgun_bullet_body_entered(body):
	self.hide()
	$AnimatedSprite2D/AudioStreamPlayer.play()
	await get_tree().create_timer(1).timeout
