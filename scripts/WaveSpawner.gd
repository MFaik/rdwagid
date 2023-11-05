extends Node2D

@onready var score_label : Label = $ScoreLabel
var score = 0

@onready var boulder = preload("res://boulder.tscn")
@onready var bat = preload("res://bat.tscn")

var wave_time = 0
var wave_duration = 7

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	score += delta
	score_label.text = "Score: %s" % floor(score)

	if wave_time > wave_duration:
		wave_time = 0
		if wave_duration > 5:
			wave_duration -= 0.2
			hard()
		elif wave_duration > 3:
			wave_duration -= 0.1
			normal()
		else:
			hard()
	else:
		wave_time += delta

func easy():
	if randi_range(0, 1) == 0:
		var b = boulder.instantiate()
		b.add_to_group("Enemy")
		b.position = Vector2(650, 400)
		add_child(b)
	else:
		spawn_bat()

func spawn_bat():
	var b = bat.instantiate()
	b.add_to_group("Enemy")
	b.position = Vector2(650, randi_range(50, 150))
	add_child(b)

func normal():
	easy()
	await get_tree().create_timer(3).timeout
	easy()

func hard():
	easy()
	spawn_bat()
	await get_tree().create_timer(1.5).timeout
	spawn_bat()
	await get_tree().create_timer(1.5).timeout
	easy()
	spawn_bat()


func _on_button_pressed():
	get_tree().reload_current_scene()
