extends Control

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_restart_button_pressed() -> void:
	GlobalVars.score = 0
	get_tree().change_scene_to_file("res://scenes/game.tscn")
