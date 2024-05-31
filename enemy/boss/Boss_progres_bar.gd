extends TextureProgressBar

func _ready():
	update()

func update():
	value = Globals.boss_health
