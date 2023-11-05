extends Area2D

var velocity 

func _process(delta):
	position += velocity * delta
	
	if position.y >  2000 or abs(position.x) > 2000:
		queue_free()
