extends CharacterBody2D
class_name Entity

signal hp_changed(new_hp)       
signal hp_max_changed(new_hp_max) 
signal died 

@export var hp_max: int = 100: set = set_hp_max
@export var hp: int = hp_max: get = get_hp, set = set_hp
@export var speed: int = 40                             # acceleration
@export var max_speed: int = 100                        # speed
@export var is_knockback: bool = true
@export var knockback_modifier: float = 0.1

const FRICTION: float = 0.15

@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var coll_shape = $CollisionShape2D



var move_direction: Vector2 = Vector2.ZERO  # movement vector
	  # speed vector

func _physics_process(delta):
	set_velocity(velocity)
	move_and_slide()
	velocity = velocity
	velocity = lerp(velocity, Vector2.ZERO, FRICTION) # sample speed
	move()
	
func move():
	move_direction = move_direction.normalized()  # normalize vector
	velocity += move_direction * speed 
	velocity = velocity.limit_length(max_speed)        # clamp speed	

func receive_damage(damage: int):
	self.hp -= damage

func set_hp(value):
	if value != hp:
		hp = clamp(value, 0, hp_max) # clamp health
		emit_signal("hp_changed", hp)
		if hp == 0:
			coll_shape.set_deferred("disabled", true)
			$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
			emit_signal("died")
			
func get_hp():
	return hp
	
func set_hp_max(value):
	if value != hp_max:
		hp_max = max(0, value)
