extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass	

func _on_opponent_1_hitbox_body_entered(body):
	Global.goto_game("Awake Now")


func _on_opponent_5_hitbox_body_entered(body):
	Global.goto_game("Getcha")


func _on_opponent_4_hitbox_body_entered(body):
	Global.goto_game("Paradise")


func _on_opponent_3_hitbox_body_entered(body):
	Global.goto_game("Daybreak Frontline")


func _on_opponent_2_hitbox_body_entered(body):
	Global.goto_game("Entertain Me")


func _on_opponent_6_hitbox_body_entered(body):
	Global.goto_game("Infinitely Gray")


func _on_opponent_7_hitbox_body_entered(body):
	Global.goto_game("Don't Fight The Music")
