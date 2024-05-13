extends Entity

const SMOOTH := 0.1
var is_alive : bool = true
@export var bullet: PackedScene = preload("res://bullets/Pistol_bullet.tscn")
@onready var weapon = $Pistol
@onready var muzzle = $Pistol/Pistol_muzzle
@onready var fire_speed = $Fire_speed
func _process(delta: float):
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	if is_alive:
		# Animations
		if mouse_direction.x > 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false
		elif mouse_direction.x < 0 and not animated_sprite.flip_h:
			animated_sprite.flip_h = true
			
		if move_direction != Vector2.ZERO:
			animated_sprite.play("run")
		else:
			# player is idle
			animated_sprite.play("idle") 
		
		weapon.look_at(get_global_mouse_position())
		if get_global_mouse_position().x < position.x:
			weapon.flip_v = true
			weapon.offset = Vector2(3, -1)
		else:
			weapon.flip_v = false
			weapon.offset = Vector2(3, 1)
		
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
			print("xx")
			shoot()
			
		if Input.is_action_pressed("weapon_pistol"):
			weapon = $Pistol
			muzzle = $Pistol/Pistol_muzzle
			
		if Input.is_action_pressed("weapon_machinegun"):
			weapon = $Machinegun
			muzzle = $Machinegun/Machinegun_muzzle
		if Input.is_action_pressed("weapon_shotgun"):
			weapon = $Shotgun
			muzzle = $Shotgun/Shotgun_muzzle
		if Input.is_action_pressed("weapon_railgun"):
			weapon = $Railgun
			muzzle = $Railgun/Railgun_muzzle

func shoot():
	if bullet:
		var bullet_instance = bullet.instantiate()
		get_tree().current_scene.add_child(bullet_instance)
		bullet_instance.global_position = muzzle.global_position
		bullet_instance.rotation_degrees = weapon.rotation_degrees
		fire_speed.start()


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
