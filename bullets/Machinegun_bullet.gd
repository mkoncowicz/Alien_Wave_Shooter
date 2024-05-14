extends Area2D

@export  var bullet_speed: int = 4

func _ready():
	pass 

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += bullet_speed * direction	

func destroy():

	queue_free()
	
func _on_MachinegunBullet_body_entered(body: Node):
	destroy()
