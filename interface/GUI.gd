extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_ammo(weapon: String):
	if weapon == "pistol":
		$GUI/Ammo_infinity.show()
		$GUI/Ammo_mag.hide()
		$GUI/Ammo_label_space.hide()
		$GUI/Ammo_stash.hide()
	if weapon == "machinegun":
		$GUI/Ammo_infinity.hide()
		$GUI/Ammo_mag.show()
		$GUI/Ammo_label_space.show()
		$GUI/Ammo_stash.show()
		$GUI/Ammo_mag.set_text(str(Globals.machinegun_ammo_mag))
		$GUI/Ammo_stash.set_text(str(Globals.machinegun_ammo_stash))
	if weapon == "shotgun":
		$GUI/Ammo_infinity.hide()
		$GUI/Ammo_mag.show()
		$GUI/Ammo_label_space.show()
		$GUI/Ammo_stash.show()
		$GUI/Ammo_mag.set_text(str(Globals.shotgun_ammo_mag))
		$GUI/Ammo_stash.set_text(str(Globals.shotgun_ammo_stash))
		
	if weapon == "railgun":
		$GUI/Ammo_infinity.hide()
		$GUI/Ammo_mag.show()
		$GUI/Ammo_label_space.show()
		$GUI/Ammo_stash.show()
		$GUI/Ammo_mag.set_text(str(Globals.railgun_ammo_mag))
		$GUI/Ammo_stash.set_text(str(Globals.railgun_ammo_stash))

func update_score():
	$GUI/TextureRect/score.set_text(str(Globals.score))


func _on_texture_button_pressed():
	$GUI.hide()
	$Pause.pause()
