extends Area2D

func _on_Railgun_body_entered(body):
	if !body.is_in_group("enemies"):
		body.have_railgun = true
		Globals.railgun_ammo_mag = Globals.railgun_ammo_max
		self.hide()
		$Sprite2D/AudioStreamPlayer.play()
		await get_tree().create_timer(1).timeout
		queue_free()
