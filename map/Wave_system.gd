extends Node

@export var slime: PackedScene = preload("res://enemy/enemySlime.tscn")
@export var alien: PackedScene = preload("res://enemy/enemyAlien.tscn")
@export var alien_shooter: PackedScene = preload("res://enemy/enemyAlienShooter.tscn")
@export var boss: PackedScene = preload("res://enemy/boss/boss.tscn")
@onready var map = find_parent("Map")
@onready var enemies_node = map.find_child("enemies")
var randomizer : RandomNumberGenerator = RandomNumberGenerator.new()
@onready var dead_enemies=0
@onready var enemie_number_waves = {
	1:4,
	2:8,
	3:8,
	4:12,
	5:12
}
func _process(delta):
	print(Globals.wave)
	print(dead_enemies)

func enemy_death():
	print("enemy death")
	dead_enemies+=1
	if dead_enemies == enemie_number_waves[Globals.wave]:
		$Beteween_waves.start()
		dead_enemies=0


func _ready():
	add_to_group("level")
	randomizer.randomize()

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
		
		

func update_level(level):
	match level:
		1:
				start_spawning(1)
		2:
				start_spawning(2)
		3:
				start_spawning(2)
		4:
				start_spawning(3)
		5:
				start_spawning(3)
		6:
				print("end")
func _on_beteween_waves_timeout():
	print("Loading:", Globals.wave)
	Globals.wave += 1
	if Globals.wave == 6:
		print("end")
		return
	update_level(Globals.wave)
