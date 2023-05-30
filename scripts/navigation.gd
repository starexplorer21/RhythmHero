extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass	

func _on_opponent_1_hitbox_body_entered(body):
	Global.goto_game("Don't Fight The Music")
