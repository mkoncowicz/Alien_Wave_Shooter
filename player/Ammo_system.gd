extends Node
@onready var reload_timer = $Reload_timer

func update(weapon: String):
		
	if weapon == "machinegun":
		Globals.machinegun_ammo_mag -= 1
		
	if weapon == "shotgun":
		Globals.shotgun_ammo_mag -= 3
		
	if weapon == "railgun":
		Globals.railgun_ammo_mag -= 1
		

func reload(weapon: String):
	if reload_timer.is_stopped():
		if weapon == "machinegun":
			if Globals.machinegun_ammo_stash <= 0:
				return
			if Globals.machinegun_ammo_mag < Globals.machinegun_ammo_max:
				var ammo_missing := Globals.machinegun_ammo_max - Globals.machinegun_ammo_mag
				if Globals.machinegun_ammo_stash >= ammo_missing:
					Globals.machinegun_ammo_stash = Globals.machinegun_ammo_stash - ammo_missing
					Globals.machinegun_ammo_mag = Globals.machinegun_ammo_max
				else:
					Globals.machinegun_ammo_mag += Globals.machinegun_ammo_stash
					Globals.machinegun_ammo_stash = 0
				reload_timer.start()
				await get_tree().create_timer(1).timeout
			else:
				return
			
		if weapon == "shotgun":
			if Globals.shotgun_ammo_stash <= 0:
				return
			if Globals.shotgun_ammo_mag < Globals.shotgun_ammo_max:
				var ammo_missing := Globals.shotgun_ammo_max - Globals.shotgun_ammo_mag
				if Globals.shotgun_ammo_stash >= ammo_missing:
					Globals.shotgun_ammo_stash = Globals.shotgun_ammo_stash- ammo_missing
					Globals.shotgun_ammo_mag = Globals.shotgun_ammo_max
				else:
					Globals.shotgun_ammo_mag += Globals.shotgun_ammo_stash
					Globals.shotgun_ammo_stash = 0
				reload_timer.start()
				await get_tree().create_timer(1).timeout
			else:
				return
			
		if weapon == "railgun":
			if Globals.railgun_ammo_stash <= 0:
				return
			if Globals.railgun_ammo_mag < Globals.railgun_ammo_max:
				var ammo_missing := Globals.railgun_ammo_max - Globals.railgun_ammo_mag
				if Globals.railgun_ammo_stash >= ammo_missing:
					Globals.railgun_ammo_stash = Globals.railgun_ammo_stash - ammo_missing
					Globals.railgun_ammo_mag = Globals.railgun_ammo_max
				else:
					Globals.railgun_ammo_mag += Globals.railgun_ammo_stash
					Globals.railgun_ammo_stash = 0
				reload_timer.start()
				await get_tree().create_timer(1).timeout
			else:
				return
