extends Node

@export var machinegun_ammo: PackedScene = preload("res://pickups/Machinegun_bullet.tscn")
@export var shotgun_ammo: PackedScene = preload("res://pickups/Shotgun_bullet.tscn")
@export var railgun_ammo: PackedScene = preload("res://pickups/Railgun_bullet.tscn")
@export var aidkit: PackedScene = preload("res://pickups/AidKit.tscn")

var randomizer : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	randomizer.randomize()

func generate_drop(position: Vector2):
	var loot_type = randomizer.randi_range(0, 2 + Globals.wave)
	var loot_instance: Node2D = null
	
	match loot_type:
		0:
			print("No loot this time")
		1:
			print("No loot this time")
		2:
			print("No loot this time")
		3:
			loot_instance = aidkit.instantiate()
		4:
			loot_instance = machinegun_ammo.instantiate()
		5:
			loot_instance = shotgun_ammo.instantiate()
		6:
			loot_instance = railgun_ammo.instantiate()
		7:
			print("No loot this time")

	if loot_instance:
		loot_instance.position = position
		add_child(loot_instance)
