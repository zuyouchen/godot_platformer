extends Node

var score = GlobalVars.score
@onready var score_label: Label = $"../GUI/ScoreLabel"
@onready var health_bar: TextureProgressBar = $"../GUI/HealthBar"
@onready var health_label: Label = $"../GUI/HealthLabel"
@onready var player: CharacterBody2D = %Player

func _ready():
	health_bar.max_value = player.max_health
	health_bar.value = player.current_health
	player.change_health.connect(update_health_bar)

func update_health_bar(new_health: int):
	health_bar.value = new_health
	health_label.text = "Health: " + str(new_health)
	
func add_point():
	GlobalVars.score += 1
	score_label.text = "Score: " + str(GlobalVars.score)

# called by health_pack.gd
func consume_health_pack():
	if player.current_health < 100:
		update_health_bar(min(100, player.current_health + 20))
		
