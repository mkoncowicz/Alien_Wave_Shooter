extends Node2D

@onready var player = $Player
var crosshair = preload("res://Assets/crosshair3.png")

func _ready():
	Input.set_custom_mouse_cursor(crosshair, Input.CURSOR_ARROW, Vector2(16,16))
	$Bacground_sound.play()
	$Bacground_music.play()

func _process(delta):
	if $Bacground_music.playing == false:
		$Bacground_music.playing = true
	if $Bacground_sound.playing == false:
		$Bacground_sound.playing = true

func _physics_process(delta):
	get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)
