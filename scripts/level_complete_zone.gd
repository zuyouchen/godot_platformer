extends Area2D

@onready var game_manager: Node = %GameManager

func _on_body_entered(body: Node2D) -> void:
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://scenes/level_complete.tscn")
