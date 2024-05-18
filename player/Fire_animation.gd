extends AnimatedSprite2D

var time : float = 0.3
func _ready():
	play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_finished():
	queue_free()

func add_fire_animation(arg:String):
	print(arg)
	set_visible(true)
	play(arg)
	await get_tree().create_timer(time).timeout
	set_visible(false)
