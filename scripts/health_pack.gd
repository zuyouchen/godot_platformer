extends Area2D

@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	game_manager.consume_health_pack()
	# same pickup animation player hack as the coin from tut
	animation_player.play("pickup")
