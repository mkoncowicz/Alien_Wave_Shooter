extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Background_sound.play()

func _process(delta):
	if $Background_sound.playing == false:
		$Background_sound.playing = true



func _on_texture_button_3_pressed():
	$Click_sound.play()
	get_tree().change_scene_to_file("res://map/Map.tscn")


func _on_texture_button_2_pressed():
	get_tree().change_scene_to_file("res://interface/Credits.tscn")


func _on_texture_button_pressed():
	$Click_sound.play()
	get_tree().quit()


func _on_texture_button_mouse_entered():
	$Hover_sound.play()


func _on_texture_button_2_mouse_entered():
	$Hover_sound.play()


func _on_texture_button_3_mouse_entered():
	$Hover_sound.play()
