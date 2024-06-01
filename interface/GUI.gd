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

func machinegun_ready():
	$GUI/Slot2/Gun.show()

func shotgun_ready():
	$GUI/Slot3/Gun.show()

func railgun_ready():
	$GUI/Slot4/Gun.show()

func pistol_selected():
	$GUI/Slot1/Slot1_border.show()
	$GUI/Slot2/Slot2_border.hide()
	$GUI/Slot3/Slot3_border.hide()
	$GUI/Slot4/Slot4_border.hide()

func machinegun_selected():
	$GUI/Slot1/Slot1_border.hide()
	$GUI/Slot2/Slot2_border.show()
	$GUI/Slot3/Slot3_border.hide()
	$GUI/Slot4/Slot4_border.hide()

func shotgun_selected():
	$GUI/Slot1/Slot1_border.hide()
	$GUI/Slot2/Slot2_border.hide()
	$GUI/Slot3/Slot3_border.show()
	$GUI/Slot4/Slot4_border.hide()

func railgun_selected():
	$GUI/Slot1/Slot1_border.hide()
	$GUI/Slot2/Slot2_border.hide()
	$GUI/Slot3/Slot3_border.hide()
	$GUI/Slot4/Slot4_border.show()

func reloading():
	$GUI/Reloading.show()
	await get_tree().create_timer(2).timeout
	$GUI/Reloading.hide()

func set_wave_counter(number: int):
	$GUI/Wave_counter.set_text("Wave "+ str(number))

func counting_to_next_wave():
	$GUI/Notification.show()
	$GUI/Notification.set_text("New weapon available by the ship")
	await get_tree().create_timer(3).timeout
	$GUI/Notification.set_text("Enemies attack in 5")
	await get_tree().create_timer(1).timeout
	$GUI/Notification.set_text("Enemies attack in 4")
	await get_tree().create_timer(1).timeout
	$GUI/Notification.set_text("Enemies attack in 3")
	await get_tree().create_timer(1).timeout
	$GUI/Notification.set_text("Enemies attack in 2")
	await get_tree().create_timer(1).timeout
	$GUI/Notification.set_text("Enemies attack in 1")
	await get_tree().create_timer(1).timeout
	$GUI/Notification.set_text("Enemies attack in 0")
	await get_tree().create_timer(1).timeout
	$GUI/Notification.hide()
	
func win_notification():
	$GUI/Notification.show()
	$GUI/Notification.set_text("YOU WIN!!!")
	
func counting_to_first_wave():
	await get_tree().create_timer(3).timeout
	$GUI/Notification.show()
	$GUI/Notification.set_text("Enemies attack in 5")
	await get_tree().create_timer(1).timeout
	$GUI/Notification.set_text("Enemies attack in 4")
	await get_tree().create_timer(1).timeout
	$GUI/Notification.set_text("Enemies attack in 3")
	await get_tree().create_timer(1).timeout
	$GUI/Notification.set_text("Enemies attack in 2")
	await get_tree().create_timer(1).timeout
	$GUI/Notification.set_text("Enemies attack in 1")
	await get_tree().create_timer(1).timeout
	$GUI/Notification.set_text("Enemies attack in 0")
	await get_tree().create_timer(1).timeout
	$GUI/Notification.hide()

func _on_texture_button_pressed():
	$GUI.hide()
	$Pause.pause()
