extends Area2D

@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.frame = randi_range(0, 3)
	
func _process(delta):
	position -= Vector2(128*delta, 72*delta)
	if position.y < -100:
		queue_free()
