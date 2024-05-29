extends AnimatedSprite2D

var weapon_type : String 
func _ready():
	if weapon_type == "pistol":
		$PointLight2D.set_color(Color(0.9765, 1, 0, 1))
		play("Pistol")
	if weapon_type == "machinegun":
		$PointLight2D.set_color(Color(1, 1, 0, 1))
		play("Machinegun")
	if weapon_type == "shotgun":
		$PointLight2D.set_color(Color(1, 0.0706, 0.0706, 1))
		play("Shotgun")
	if weapon_type == "railgun":
		$PointLight2D.set_color(Color(0, 1, 1, 1))
		play("Railgun")
	if weapon_type == "alien_gun":
		$PointLight2D.set_color(Color(0.451, 0.847, 0.004, 1))
		play("Alien_gun")
	
func _on_animation_finished():
	queue_free()
