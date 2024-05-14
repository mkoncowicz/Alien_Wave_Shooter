extends CharacterBody2D
class_name Entity

signal hp_changed(new_hp)       
signal hp_max_changed(new_hp_max) 
signal died 

@export var hp_max: int = 100: set = set_hp_max
@export var hp: int = hp_max: get = get_hp, set = set_hp
@export var speed: int = 40
@export var max_speed: int = 100                        
@export var is_knockback: bool = true
@export var knockback_modifier: float = 0.1

const FRICTION: float = 0.15

@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var coll_shape = $CollisionShape2D



var move_direction: Vector2 = Vector2.ZERO 


func _physics_process(delta):
	set_velocity(velocity)
	move_and_slide()
	velocity = velocity
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)
	move()
	
func move():
	move_direction = move_direction.normalized()
	velocity += move_direction * speed 
	velocity = velocity.limit_length(max_speed) 

func take_damage(damage: int):
	self.hp -= 30
	if self.hp <= 0:
		queue_free()

func set_hp(value):
	hp = value
			
func get_hp():
	return hp
	
func set_hp_max(value):
	if value != hp_max:
		hp_max = max(0, value)

