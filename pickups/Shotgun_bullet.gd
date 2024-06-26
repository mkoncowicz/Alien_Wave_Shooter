extends Area2D

func _ready(): 
	$AnimatedSprite2D.play("default")

func _on_Shotgun_bullet_body_entered(body):
	if !body.is_in_group("enemies"):
		Globals.shotgun_ammo_stash += 6
		self.hide()
		$AnimatedSprite2D/AudioStreamPlayer.play()
		await get_tree().create_timer(0.5).timeout
		queue_free()
