extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Click_sound.play()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_pressed():
	$Click_sound.play()
	get_tree().change_scene_to_file("res://interface/Main_interface.tscn")


func _on_texture_button_mouse_entered():
	$Hover_sound.play()
