extends Control

@onready var score_text: Label = $ScoreText

func _ready():
	score_text.text = "Score: " + str(GlobalVars.score)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_restart_button_pressed() -> void:
	GlobalVars.score = 0
	get_tree().change_scene_to_file("res://scenes/game.tscn")
