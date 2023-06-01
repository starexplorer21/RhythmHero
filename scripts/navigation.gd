extends Node2D

var song_name

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
	song_name = "Awake Now"
	$Player/Song_Select.load_assets(song_name)
	$Player/Song_Select.visible = true
	$Player.can_move = false

func _on_opponent_5_hitbox_body_entered(body):
	song_name = "Getcha"
	$Player/Song_Select.load_assets(song_name)
	$Player/Song_Select.visible = true
	$Player.can_move = false


func _on_opponent_4_hitbox_body_entered(body):
	song_name = "Paradise"
	$Player/Song_Select.load_assets(song_name)
	$Player/Song_Select.visible = true
	$Player.can_move = false


func _on_opponent_3_hitbox_body_entered(body):
	song_name = "Daybreak Frontline"
	$Player/Song_Select.load_assets(song_name)
	$Player/Song_Select.visible = true
	$Player.can_move = false


func _on_opponent_2_hitbox_body_entered(body):
	song_name = "Entertain Me"
	$Player/Song_Select.load_assets(song_name)
	$Player/Song_Select.visible = true
	$Player.can_move = false


func _on_opponent_6_hitbox_body_entered(body):
	song_name = "Infinitely Gray"
	$Player/Song_Select.load_assets(song_name)
	$Player/Song_Select.visible = true
	$Player.can_move = false


func _on_opponent_7_hitbox_body_entered(body):
	song_name = "Don't Fight The Music"
	$Player/Song_Select.load_assets(song_name)
	$Player/Song_Select.visible = true
	$Player.can_move = false

func _on_opponent_8_hitbox_body_entered(body):
	song_name = "Lower"
	$Player/Song_Select.load_assets(song_name)
	$Player/Song_Select.visible = true
	$Player.can_move = false


func _on_song_select_play():
	Global.goto_game(song_name)

func _on_song_select_closed():
	$Player/Song_Select.visible = false
	$Player.can_move = true


func _on_pause_pressed():
	$Player.can_move = false
	show_pause()
	
func show_pause():
	$Player/Continue.visible = true
	$Player/Save.visible = true
	$Player/Quit.visible = true
	$Player/Continue.disabled = false
	$Player/Save.disabled = false
	$Player/Quit.disabled = false


func _on_continue_pressed():
	$Player.can_move = true
	$Player/Continue.visible = false
	$Player/Save.visible = false
	$Player/Quit.visible = false
	$Player/Continue.disabled = true
	$Player/Save.disabled = true
	$Player/Quit.disabled = true


func _on_save_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	pass # Replace with function body.
