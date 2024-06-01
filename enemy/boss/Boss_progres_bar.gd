extends TextureProgressBar
func _start():
	update()

func _process(delta):
	update()

func update():
	value = Globals.boss_health
