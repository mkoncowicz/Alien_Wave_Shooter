extends Area2D


func _ready(): 
	$AnimatedSprite2D.play("default")

func _on_Machinegun_bullet_body_entered(body):
	if !body.is_in_group("enemies"):
		Globals.machinegun_ammo_stash = Globals.machinegun_ammo_max
		self.hide()
		$AnimatedSprite2D/AudioStreamPlayer.play()
		await get_tree().create_timer(1).timeout
		queue_free()
