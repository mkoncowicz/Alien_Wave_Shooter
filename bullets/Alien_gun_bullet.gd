extends Area2D

@export  var bullet_speed: int = 2
@export var hit_animation: PackedScene = preload("res://bullets/bullet_hit_animation.tscn")
@onready var hit_point = $Hit_point

func _ready():
	pass 

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += bullet_speed * direction

func destroy():
	queue_free()

func _on_Alien_shooter_bullet_body_entered(body):
	if !body.is_in_group("enemies"):
		var hit_animation_instance = hit_animation.instantiate()
		hit_animation_instance.weapon_type = "alien_gun"
		get_tree().current_scene.add_child(hit_animation_instance)
		hit_animation_instance.position = hit_point.global_position
		hit_animation_instance.rotation_degrees = self.rotation_degrees
		queue_free()
		if body.has_method("player_take_damage"):
			body.player_take_damage(30)
		
