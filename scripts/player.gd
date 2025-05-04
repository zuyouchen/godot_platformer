extends CharacterBody2D

const SPEED = 120.0
const JUMP_VELOCITY = -300.0

@export var max_health = 100
@export var current_health = max_health

signal change_health(new_health)

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var invulnerable = false

func _ready():
	Engine.time_scale = 1.0
	emit_signal("change_health", current_health)

func _physics_process(delta: float) -> void:
	# apply knockback
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= delta
		if knockback_timer <= 0:
			knockback = Vector2.ZERO
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0: 
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")	
	else:
		animated_sprite.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func take_damage(amount):
	if not invulnerable:
		current_health = max(current_health - amount, 0)
		emit_signal("change_health", current_health)
		handle_invulnerability()
	if current_health <= 0:
		die()

func handle_invulnerability():
	invulnerable = true
	await get_tree().create_timer(1).timeout
	invulnerable = false

func die():
	await get_tree().create_timer(0.3).timeout
	GlobalVars.score = 0
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")

var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0

func apply_knockback(direction: Vector2, force: float, knockback_duration: float) -> void:
	knockback = direction * force
	knockback_timer = knockback_duration 
