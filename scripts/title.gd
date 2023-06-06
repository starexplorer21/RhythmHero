extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Difficulty.text = "Current Difficulty: " + Global.difficulty


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	Global.goto_navigation(0.0, "", false, false)


func _on_change_difficulty_pressed():
	if Global.difficulty == "Normal":
		Global.difficulty = "Easy"
	elif Global.difficulty == "Easy":
		Global.difficulty = "Normal"
	$Difficulty.text = "Current Difficulty: " + Global.difficulty
	


func _on_tutorial_pressed():
	Global.goto_tutorial()
