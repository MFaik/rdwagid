extends CharacterBody2D

@onready var bullet = preload("res://bullet.tscn")

@onready var player = $AnimatedSprite2D
@onready var bullet_pos = $BulletSpawnPos
@onready var hill = get_tree().root.get_child(0)

@export var lost : Label

const JUMP_VELOCITY = -480.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 320

var can_jump = true
var can_shoot = false
var shoot_timer = 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if not Input.is_action_pressed("jump") and velocity.y < 0:
			velocity.y += gravity * 2 * delta
		velocity.y += gravity * delta
	
	if can_shoot and not can_jump and is_on_floor():
		fall()
		
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and can_jump and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump()

	move_and_slide()
	
	if shoot_timer < 0.6:
		shoot_timer += delta
	elif Input.is_action_pressed("shoot") and can_shoot:
		shoot_timer = 0
		
		var b = bullet.instantiate()
		b.add_to_group("PlayerBullet")
		b.position = bullet_pos.position + position
		hill.add_child(b)

func fall():
	can_shoot = false
	player.play("falling")
	await player.animation_finished
	player.play("rolling")
	can_jump = true

func jump():
	can_jump = false
	player.play("jumping")
	await player.animation_finished
	player.play("flying")
	can_shoot = true


func _on_area_2d_area_entered(area : Area2D):
	if area.is_in_group("Enemy"):
		get_tree().paused = true
		lost.visible = true
