extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	Global.goto_navigation(0.0, "")


func _on_change_difficulty_pressed():
	if Global.difficulty == "Normal":
		Global.difficulty = "Easy"
	elif Global.difficulty == "Easy":
		Global.difficulty = "Normal"
	$Difficulty.text = "Current Difficulty: " + Global.difficulty
	
