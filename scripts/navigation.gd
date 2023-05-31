extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.unlocked_level2:
		open_level2()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass	

func open_level2():
	for i in range(20):
		$TileMap.set_cell(0, Vector2i(53+i, 7), 0, Vector2i(2, 0))
		$TileMap.set_cell(0, Vector2i(53+i, 8), 0, Vector2i(2, 2))
	for i in range(4):
		$TileMap2.erase_cell(0, Vector2i(57, 6+i))
	$TileMap2.set_cell(0, Vector2i(57, 5), 5, Vector2i(0,2))
	$TileMap2.set_cell(0, Vector2i(57, 10), 5, Vector2i(0,0))
	
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

func _on_opponent_8_hitbox_body_entered(body):
	Global.goto_game("Lower")
