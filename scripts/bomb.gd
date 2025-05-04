extends AnimatableBody2D

@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var explosion_area: Area2D = $ExplosionArea

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_left.is_colliding():
		animated_sprite.play("explode")
		# created an animation that handles the audio and queue_free()
		animation_player.play("explode")

func _on_explosion_area_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(20)
		# apply knockback (defined in player.gd)
		var knockback_direction = (body.global_position - global_position).normalized()
		body.apply_knockback(knockback_direction, 300.0, 0.3)
