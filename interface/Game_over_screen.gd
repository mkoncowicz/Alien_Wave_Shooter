extends Control

func _ready():
	$Background_sound.play()
	var score = Globals.score
	$TextureRect5/Row3/Score_value.set_text(str(score))

func _process(delta):
	if $Background_sound.playing == false:
		$Background_sound.playing = true

func _on_exit_button_pressed():
	$Click_sound.play()
	get_tree().quit()

func _on_exit_button_mouse_entered():
	$Hover_sound.play()
