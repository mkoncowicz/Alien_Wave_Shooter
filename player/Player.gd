extends Entity

const SMOOTH := 0.09
var is_alive : bool = true
@export var bullet: PackedScene = preload("res://bullets/Pistol_bullet.tscn")
@export var Machinegun_bullet: PackedScene = preload("res://bullets/Machinegun_bullet.tscn")
@export var Shotgun_bullet: PackedScene = preload("res://bullets/Shotgun_bullet.tscn")
@export var Railgun_bullet: PackedScene = preload("res://bullets/Railgun_bullet.tscn")
@onready var weapon = $Pistol
@onready var muzzle = $Pistol/Pistol_muzzle
@onready var Shotgun_muzzle2 = $Shotgun/Shotgun_muzzle2
@onready var Shotgun_muzzle3 = $Shotgun/Shotgun_muzzle3
@onready var fire_speed = $Fire_speed
@onready var fire_animation = $Fire_animation
@onready var flash_position = $Pistol/Pistol_flash
@onready var weapon_change_speed = 0.09

func _process(delta: float):
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	fire_animation.global_position = flash_position.global_position
	if is_alive:
		if mouse_direction.x > 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false
		elif mouse_direction.x < 0 and not animated_sprite.flip_h:
			animated_sprite.flip_h = true
			
		if move_direction != Vector2.ZERO:
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle") 
		$Pistol.look_at(get_global_mouse_position())
		$Machinegun.look_at(get_global_mouse_position())
		$Shotgun.look_at(get_global_mouse_position())
		$Railgun.look_at(get_global_mouse_position())
		weapon.look_at(get_global_mouse_position())
		if get_global_mouse_position().x < position.x:
			weapon.flip_v = true
		else:
			weapon.flip_v = false
			
		handle_camera()
		get_input()
		weaponManager()
		
func get_input():
	if is_alive:
		move_direction = Vector2.ZERO
		if Input.is_action_pressed("ui_down"):
			move_direction += Vector2.DOWN
		if Input.is_action_pressed("ui_up"):
			move_direction += Vector2.UP
		if Input.is_action_pressed("ui_left"):
			move_direction += Vector2.LEFT
		if Input.is_action_pressed("ui_right"):
			move_direction += Vector2.RIGHT
			
		if Input.is_action_pressed("fire") and fire_speed.is_stopped():
			shoot()
			
		if Input.is_action_pressed("weapon_pistol"):
			await get_tree().create_timer(weapon_change_speed).timeout
			weapon = $Pistol
			muzzle = $Pistol/Pistol_muzzle
			flash_position = $Pistol/Pistol_flash
		if Input.is_action_pressed("weapon_machinegun"):
			await get_tree().create_timer(weapon_change_speed).timeout
			weapon = $Machinegun
			muzzle = $Machinegun/Machinegun_muzzle
			flash_position = $Machinegun/Machinegun_flash
		if Input.is_action_pressed("weapon_shotgun"):
			await get_tree().create_timer(weapon_change_speed).timeout
			weapon = $Shotgun
			muzzle = $Shotgun/Shotgun_muzzle
			flash_position = $Shotgun/Shotgun_flash
		if Input.is_action_pressed("weapon_railgun"):
			await get_tree().create_timer(weapon_change_speed).timeout
			weapon = $Railgun
			muzzle = $Railgun/Railgun_muzzle
			flash_position = $Railgun/Railgun_flash


func shoot():
	if weapon == $Pistol:
		var bullet_instance = bullet.instantiate()
		get_tree().current_scene.add_child(bullet_instance)
		bullet_instance.global_position = muzzle.global_position
		bullet_instance.rotation_degrees = weapon.rotation_degrees
		fire_animation.add_fire_animation("pistol")
		fire_speed.start()
	if weapon == $Machinegun:
		var bullet_instance = Machinegun_bullet.instantiate()
		get_tree().current_scene.add_child(bullet_instance)
		bullet_instance.global_position = muzzle.global_position
		bullet_instance.rotation_degrees = weapon.rotation_degrees
		fire_animation.add_fire_animation("machinegun")
		Globals.machinegun_ammo_mag -= 1
		print(Globals.machinegun_ammo_mag)
		fire_speed.start()
	if weapon == $Shotgun:
		var bullet_instance = Shotgun_bullet.instantiate()
		get_tree().current_scene.add_child(bullet_instance)
		bullet_instance.global_position = muzzle.global_position
		bullet_instance.rotation_degrees = weapon.rotation_degrees
		
		var bullet_instance2 = Shotgun_bullet.instantiate()
		get_tree().current_scene.add_child(bullet_instance2)
		bullet_instance2.global_position = Shotgun_muzzle2.global_position
		bullet_instance2.rotation_degrees = weapon.rotation_degrees - 8
		
		var bullet_instance3 = Shotgun_bullet.instantiate()
		get_tree().current_scene.add_child(bullet_instance3)
		bullet_instance3.global_position = Shotgun_muzzle3.global_position
		bullet_instance3.rotation_degrees = weapon.rotation_degrees + 8
		fire_animation.add_fire_animation("shotgun")
		Globals.shotgun_ammo_mag -= 3
		print(Globals.shotgun_ammo_mag)
		fire_speed.start()
	if weapon == $Railgun:
		var bullet_instance = Railgun_bullet.instantiate()
		get_tree().current_scene.add_child(bullet_instance)
		bullet_instance.global_position = muzzle.global_position
		bullet_instance.rotation_degrees = weapon.rotation_degrees
		fire_animation.add_fire_animation("railgun")
		Globals.railgun_ammo_mag -= 1
		print(Globals.railgun_ammo_mag)
		fire_speed.start()

func handle_camera():
	var new_camera_position = global_position + (get_global_mouse_position() - global_position) * SMOOTH
	$Camera2D.global_position = new_camera_position

func player_take_damage(damage: int):
	self.hp -= 30
	if self.hp <= 0:
		queue_free()

func weaponManager():
	if weapon == $Pistol:
		$Pistol.set_visible(true)
		$Machinegun.set_visible(false)
		$Shotgun.set_visible(false)
		$Railgun.set_visible(false)
	if weapon == $Machinegun:
		$Pistol.set_visible(false)
		$Machinegun.set_visible(true)
		$Shotgun.set_visible(false)
		$Railgun.set_visible(false)
	if weapon == $Shotgun:
		$Pistol.set_visible(false)
		$Machinegun.set_visible(false)
		$Shotgun.set_visible(true)
		$Railgun.set_visible(false)
	if weapon == $Railgun:
		$Pistol.set_visible(false)
		$Machinegun.set_visible(false)
		$Shotgun.set_visible(false)
		$Railgun.set_visible(true)




