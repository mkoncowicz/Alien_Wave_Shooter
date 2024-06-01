extends Node
@export var machinegun: PackedScene = preload("res://pickups/Machinegun.tscn")
@export var shotgun: PackedScene = preload("res://pickups/Shotgun.tscn")
@export var railgun: PackedScene = preload("res://pickups/Railgun.tscn")
@export var slime: PackedScene = preload("res://enemy/enemySlime.tscn")
@export var alien: PackedScene = preload("res://enemy/enemyAlien.tscn")
@export var alien_shooter: PackedScene = preload("res://enemy/enemyAlienShooter.tscn")
@export var boss: PackedScene = preload("res://enemy/boss/boss.tscn")
@onready var map = find_parent("Map")
@onready var enemies_node = map.find_child("enemies")
@onready var obstackles_node = map.find_child("obstackles")
@onready var gui = map.find_child("Player").find_child("GUI")
var randomizer : RandomNumberGenerator = RandomNumberGenerator.new()
@onready var dead_enemies=0
@onready var final_level=false
@onready var boss_is_dead=false
@onready var enemie_number_waves = {
	1:20,
	2:24,
	3:28,
	4:32,
	5:28
}
func _process(delta):
	print(Globals.wave)
	print(dead_enemies)
func enemy_death():
	print("enemy death")
	dead_enemies+=1
	if dead_enemies == enemie_number_waves[Globals.wave]:
		if !final_level:
			spawn_gun(Globals.wave)
			$Beteween_waves.start()
			dead_enemies=0
			if Globals.wave < 4:
				gui.counting_to_next_wave()
			else:
				gui.counting_to_first_wave()
		if final_level and boss_is_dead:
			gui.win_notification()
			await get_tree().create_timer(5).timeout
			get_tree().change_scene_to_file("res://interface/Game_over_screen.tscn")


func _ready():
	add_to_group("level")
	randomizer.randomize()
	gui.counting_to_first_wave()

func spawn_boss():
	var boss_instance = boss.instantiate()
	boss_instance.global_position = $Boss_spawn.global_position
	enemies_node.add_child(boss_instance)
	
func start_spawning(number: int):
	spawner1(number)
	spawner2(number)
	spawner3(number)
	spawner4(number)


func generate_enemy(position: Vector2):
	var enemy_type = randomizer.randi_range(1,Globals.wave)
	var enemy_instance: Node2D = null
	
	match enemy_type:
		1:
			enemy_instance = slime.instantiate()
		2:
			enemy_instance = alien.instantiate()
		3:
			enemy_instance = alien_shooter.instantiate()
		4:
			enemy_instance = slime.instantiate()
		5:
			enemy_instance = alien_shooter.instantiate()

	if enemy_instance:
		enemy_instance.global_position = position
		enemies_node.add_child(enemy_instance)
		print("spawned")

func spawner1(number: int):
	for i in range(number):
		generate_enemy($Spawn_point1.global_position)
		await get_tree().create_timer(1).timeout

func spawner2(number: int):
	for i in range(number):
		generate_enemy($Spawn_point2.global_position)
		await get_tree().create_timer(1).timeout

func spawner3(number: int):
	for i in range(number):
		generate_enemy($Spawn_point3.global_position)
		await get_tree().create_timer(1).timeout
	
func spawner4(number: int):
	for i in range(number):
		generate_enemy($Spawn_point4.global_position)
		await get_tree().create_timer(1).timeout
		
		

func spawn_gun(Gun: int):
	match Gun:
		1:
			var gun_instance = machinegun.instantiate()
			gun_instance.global_position = $machinegun_spawnpoint.global_position
			obstackles_node.add_child(gun_instance)
		2:
			var gun_instance = shotgun.instantiate()
			gun_instance.global_position = $shotgun_spawnpoint.global_position
			obstackles_node.add_child(gun_instance)
		3:
			var gun_instance = railgun.instantiate()
			gun_instance.global_position = $railgun_spawnpoint.global_position
			obstackles_node.add_child(gun_instance)
	

func update_level(level):
	match level:
		1:
				start_spawning(5)
				gui.set_wave_counter(Globals.wave)
		2:
				start_spawning(6)
				gui.set_wave_counter(Globals.wave)
		3:
				start_spawning(7)
				gui.set_wave_counter(Globals.wave)
		4:
				start_spawning(8)
				gui.set_wave_counter(Globals.wave)
		5:
				start_spawning(7)
				spawn_boss()
				gui.set_wave_counter(Globals.wave)
				final_level = true
		6:
				print("end")
func _on_beteween_waves_timeout():
	print("Loading:", Globals.wave)
	Globals.wave += 1
	if Globals.wave == 6:
		print("end")
		return
	update_level(Globals.wave)
	
func set_boss_is_dead():
	boss_is_dead = true
