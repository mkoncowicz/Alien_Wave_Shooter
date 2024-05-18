extends Node2D

@onready var player = $Player
var crosshair = preload("res://Assets/crosshair3.png")

func _ready():
	Input.set_custom_mouse_cursor(crosshair, Input.CURSOR_ARROW, Vector2(16,16))
	

func _physics_process(delta):
	get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)
