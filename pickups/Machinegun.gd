extends Area2D
@onready var map = find_parent("Map")
@onready var gui = map.find_child("Player").find_child("GUI")

func _on_Machinegun_body_entered(body):
	if !body.is_in_group("enemies"):
		gui.machinegun_ready()
		body.have_machinegun = true
		Globals.machinegun_ammo_mag = Globals.machinegun_ammo_max
		self.hide()
		$Sprite2D/AudioStreamPlayer.play()
		await get_tree().create_timer(0.5).timeout
		queue_free()
