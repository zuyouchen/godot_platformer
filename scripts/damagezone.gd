extends Area2D

@onready var on_hit_sfx: AudioStreamPlayer2D = $OnHitSFX

func _on_body_entered(body: Node2D) -> void:
	on_hit_sfx.play()
	if body.has_method("take_damage"):
		body.take_damage(20)
		# apply knockback (defined in player.gd)
		var knockback_direction = (body.global_position - global_position).normalized()
		body.apply_knockback(knockback_direction, 200.0, 0.2)
		
