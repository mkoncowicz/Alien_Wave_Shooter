extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_texture_button_pressed():
	unpause()

func _on_texture_button_2_pressed():
	get_tree().quit()

func unpause():
	$CanvasLayer.hide()
	$"../GUI".show()
	get_tree().paused = false
	
func pause():
	get_tree().paused = true
	$CanvasLayer.show()
