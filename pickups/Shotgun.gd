extends Area2D

func _on_Shotgun_body_entered(body):
	if !body.is_in_group("enemies"):
		body.have_shotgun = true
		Globals.shotgun_ammo_mag = Globals.shotgun_ammo_max
		self.hide()
		$Sprite2D/AudioStreamPlayer.play()
		await get_tree().create_timer(1).timeout
		queue_free()
