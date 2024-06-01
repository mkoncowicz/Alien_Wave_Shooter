extends Area2D
@onready var map = find_parent("Map")
@onready var gui = map.find_child("Player").find_child("GUI")

func _ready():
	$GPUParticles2D.set_deferred("emitting", true) 

func _on_Railgun_body_entered(body):
	if !body.is_in_group("enemies"):
		gui.railgun_ready()
		body.have_railgun = true
		Globals.railgun_ammo_mag = Globals.railgun_ammo_max
		self.hide()
		$Sprite2D/AudioStreamPlayer.play()
		await get_tree().create_timer(0.5).timeout
		queue_free()
