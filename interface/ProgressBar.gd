extends TextureProgressBar

func _ready():
	update()

func update():
	value = Globals.player_health

