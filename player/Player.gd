extends Entity

const SMOOTH := 0.09
var is_alive : bool = true
var have_machinegun : bool = false
var have_shotgun : bool = false
var have_railgun : bool = false
@export var bullet: PackedScene = preload("res://bullets/Pistol_bullet.tscn")
@export var Machinegun_bullet: PackedScene = preload("res://bullets/Machinegun_bullet.tscn")
@export var Shotgun_bullet: PackedScene = preload("res://bullets/Shotgun_bullet.tscn")
@export var Railgun_bullet: PackedScene = preload("res://bullets/Railgun_bullet.tscn")
@onready var ammo_system = $Ammo_system
@onready var reload_timer = $Ammo_system/Reload_timer
@onready var foot_step = $Foot_step
@onready var blood = $Blood
@onready var weapon = $Pistol
@onready var muzzle = $Pistol/Pistol_muzzle
@onready var Shotgun_muzzle2 = $Shotgun/Shotgun_muzzle2
@onready var Shotgun_muzzle3 = $Shotgun/Shotgun_muzzle3
@onready var fire_speed = $Fire_speed
@onready var immortal_frame = $immframe
@onready var fire_animation = $Fire_animation
@onready var flash_position = $Pistol/Pistol_flash
@onready var weapon_change_speed = 0.09
func _ready():
	hp=250

func _process(delta: float):
	$Camera2D/GUI/GUI/TextureRect/ProgressBar.update()
	if !Globals.player_is_dead == true:
		Globals.player_health = hp
		var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
		fire_animation.global_position = flash_position.global_position
		if is_alive:
			if mouse_direction.x > 0 and animated_sprite.flip_h:
				animated_sprite.flip_h = false
			elif mouse_direction.x < 0 and not animated_sprite.flip_h:
				animated_sprite.flip_h = true
				
			if move_direction != Vector2.ZERO:
				if immortal_frame.is_stopped():
					animated_sprite.play("run")
					if animated_sprite.frame == 2 or animated_sprite.frame == 4:
						foot_step.set_deferred("emitting", true) 
			else:
				if immortal_frame.is_stopped():
					animated_sprite.play("idle") 
					foot_step.set_deferred("emitting", false) 
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
	if !Globals.player_is_dead == true:
		move_direction = Vector2.ZERO
		if Input.is_action_pressed("ui_down"):
			move_direction += Vector2.DOWN
		if Input.is_action_pressed("ui_up"):
			move_direction += Vector2.UP
		if Input.is_action_pressed("ui_left"):
			move_direction += Vector2.LEFT
		if Input.is_action_pressed("ui_right"):
			move_direction += Vector2.RIGHT
			
		if Input.is_action_pressed("fire") and fire_speed.is_stopped() and reload_timer.is_stopped():
			shoot()
		
		if Input.is_action_pressed("weapon_pistol") and reload_timer.is_stopped():
			await get_tree().create_timer(weapon_change_speed).timeout
			$Fire_speed.set_wait_time(0.3)
			$Camera2D/GUI.pistol_selected()
			weapon = $Pistol
			muzzle = $Pistol/Pistol_muzzle
			flash_position = $Pistol/Pistol_flash
		if Input.is_action_pressed("weapon_machinegun") and reload_timer.is_stopped() and have_machinegun == true:
			await get_tree().create_timer(weapon_change_speed).timeout
			$Fire_speed.set_wait_time(0.15)
			$Camera2D/GUI.machinegun_selected()
			weapon = $Machinegun
			muzzle = $Machinegun/Machinegun_muzzle
			flash_position = $Machinegun/Machinegun_flash
		if Input.is_action_pressed("weapon_shotgun") and reload_timer.is_stopped() and have_shotgun == true:
			await get_tree().create_timer(weapon_change_speed).timeout
			$Fire_speed.set_wait_time(0.4)
			$Camera2D/GUI.shotgun_selected()
			weapon = $Shotgun
			muzzle = $Shotgun/Shotgun_muzzle
			flash_position = $Shotgun/Shotgun_flash
		if Input.is_action_pressed("weapon_railgun") and reload_timer.is_stopped() and have_railgun == true:
			await get_tree().create_timer(weapon_change_speed).timeout
			$Fire_speed.set_wait_time(0.3)
			$Camera2D/GUI.railgun_selected()
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
		$Pistol/Pistol_sound.play()
	if weapon == $Machinegun:
		if Globals.machinegun_ammo_mag == 0:
			ammo_system.reload("machinegun")
			print("no ammmo") 
		else:
			ammo_system.update("machinegun")
			var bullet_instance = Machinegun_bullet.instantiate()
			get_tree().current_scene.add_child(bullet_instance)
			bullet_instance.global_position = muzzle.global_position
			bullet_instance.rotation_degrees = weapon.rotation_degrees
			fire_animation.add_fire_animation("machinegun")
			fire_speed.start()
			$Machinegun/Machingun_sound.play()
	if weapon == $Shotgun:
		if Globals.shotgun_ammo_mag == 0:
			ammo_system.reload("shotgun")
			print("no ammmo") 
		else:
			ammo_system.update("shotgun")
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
			fire_speed.start()
			$Shotgun/Shotgun_sound.play()
	if weapon == $Railgun:
		if Globals.railgun_ammo_mag == 0:
			ammo_system.reload("railgun")
		else:
			ammo_system.update("railgun")
			var bullet_instance = Railgun_bullet.instantiate()
			get_tree().current_scene.add_child(bullet_instance)
			bullet_instance.global_position = muzzle.global_position
			bullet_instance.rotation_degrees = weapon.rotation_degrees
			fire_animation.add_fire_animation("railgun")
			fire_speed.start()
			$Railgun/Railgun_sound.play()

func handle_camera():
	var new_camera_position = global_position + (get_global_mouse_position() - global_position) * SMOOTH
	$Camera2D.global_position = new_camera_position

func player_take_damage(damage: int):
	if immortal_frame.is_stopped():
		immortal_frame.start()

		self.hp -= 30
		animated_sprite.play("hit")
		$Take_damage_sound.play()
		blood.set_deferred("emitting", true) 
		
		if self.hp <= 0:
			hp = 0

			Globals.player_health = hp
			Globals.player_is_dead = true
			animated_sprite.play("die")
			foot_step.set_deferred("emitting", false)
			move_direction = Vector2.ZERO
			
			await get_tree().create_timer(1.0).timeout 
			get_tree().change_scene_to_file("res://interface/Game_over_screen.tscn")

func heal(value):
	hp += value
	hp = clamp(hp, 0, hp_max)


func weaponManager():
	if weapon == $Pistol:
		$Camera2D/GUI.update_ammo("pistol")
		$Pistol.set_visible(true)
		$Machinegun.set_visible(false)
		$Shotgun.set_visible(false)
		$Railgun.set_visible(false)
	if Input.is_action_pressed("reload") and fire_speed.is_stopped() and reload_timer.is_stopped():
		ammo_system.reload("pistol")
	if weapon == $Machinegun:
		$Camera2D/GUI.update_ammo("machinegun")
		$Pistol.set_visible(false)
		$Machinegun.set_visible(true)
		$Shotgun.set_visible(false)
		$Railgun.set_visible(false)
	if Input.is_action_pressed("reload") and fire_speed.is_stopped() and reload_timer.is_stopped():
		ammo_system.reload("machinegun")
	if weapon == $Shotgun:
		$Camera2D/GUI.update_ammo("shotgun")
		$Pistol.set_visible(false)
		$Machinegun.set_visible(false)
		$Shotgun.set_visible(true)
		$Railgun.set_visible(false)
	if Input.is_action_pressed("reload") and fire_speed.is_stopped() and reload_timer.is_stopped():
		ammo_system.reload("shotgun")
	if weapon == $Railgun:
		$Camera2D/GUI.update_ammo("railgun")
		$Pistol.set_visible(false)
		$Machinegun.set_visible(false)
		$Shotgun.set_visible(false)
		$Railgun.set_visible(true)
	if Input.is_action_pressed("reload") and fire_speed.is_stopped() and reload_timer.is_stopped():
		ammo_system.reload("railgun")

