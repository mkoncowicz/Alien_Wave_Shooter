extends Entity

const SMOOTH := 0.1
var is_alive : bool = true

@onready var weapon = $Pistol

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
		else:
			weapon.flip_v = false		
			
		get_input()
		
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
			

