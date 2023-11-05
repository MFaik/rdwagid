extends AnimatedSprite2D

var time = 0
@onready var hill = get_tree().root.get_child(0)
@onready var bat_bullet = preload("res://bat_bullet.tscn")

@onready var player = get_node("/root/Hill/Player")

func _process(delta):
	position.x -= delta * 50

	if time < 2:
		time += delta
	else:
		time = 0
		var b = bat_bullet.instantiate()
		b.add_to_group("Enemy")
		b.velocity = player.position - position
		b.position = position
		hill.add_child(b)

func _on_area_2d_area_entered(area: Area2D):
	if area.is_in_group("PlayerBullet"):
		area.queue_free()
		queue_free()
