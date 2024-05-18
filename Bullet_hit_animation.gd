extends AnimatedSprite2D

var weapon_type : String 
func _ready():
	if weapon_type == "pistol":
		play("Pistol")
	if weapon_type == "machinegun":
		play("Machinegun")
	if weapon_type == "shotgun":
		play("Shotgun")
	if weapon_type == "railgun":
		play("Railgun")

	
func _on_animation_finished():
	queue_free()
