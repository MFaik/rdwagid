extends Area2D


func _process(delta):
	position.x += delta * 500
	if position.x > 2000:
		queue_free()
