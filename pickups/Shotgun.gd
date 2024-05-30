extends Area2D

func _on_Shotgun_body_entered(body):
	self.hide()
	$Sprite2D/AudioStreamPlayer.play()
	await get_tree().create_timer(1).timeout
