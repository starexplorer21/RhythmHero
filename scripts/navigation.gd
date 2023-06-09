extends Node2D

var song_name

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/Song_Select.visible = false
	if Global.unlocked_level2:
		open_level2()
	$Player/CrutchCount.text = "x"+str(Global.crutches)
	$WinText.visible = Global.crutches >= 12
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Allows escape to be used as a pause button. 
	if Input.is_action_just_pressed("ui_cancel"):
		_on_pause_pressed()

func open_level2():
	for i in range(20):
		$TileMap.set_cell(0, Vector2i(53+i, 7), 0, Vector2i(2, 0))
		$TileMap.set_cell(0, Vector2i(53+i, 8), 0, Vector2i(2, 2))
	for i in range(4):
		$TileMap2.erase_cell(0, Vector2i(57, 6+i))
	$TileMap2.set_cell(0, Vector2i(57, 5), 5, Vector2i(0,2))
	$TileMap2.set_cell(0, Vector2i(57, 10), 5, Vector2i(0,0))
	
	
# These are all the level detectors. They're out of order because I didn't 
# have the time or effort to put them in order
func _on_opponent_1_hitbox_body_entered(body):
	song_name = "Butter"
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
	song_name = "祝福(The Blessing)"
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
	
func _on_opponent_9_hitbox_body_entered(body):
	song_name = "6 Trillion Years and Overnight Story"
	$Player/Song_Select.load_assets(song_name)
	$Player/Song_Select.visible = true
	$Player.can_move = false

func _on_opponent_10_hitbox_body_entered(body):
	song_name = "What's Up Pop"
	$Player/Song_Select.load_assets(song_name)
	$Player/Song_Select.visible = true
	$Player.can_move = false

func _on_opponent_11_hitbox_body_entered(body):
	song_name = "Daybreak Frontline"
	$Player/Song_Select.load_assets(song_name)
	$Player/Song_Select.visible = true
	$Player.can_move = false

func _on_opponent_12_hitbox_body_entered(body):
	song_name = "Awake Now"
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
	$Player/Quit.visible = true
	$Player/Continue.disabled = false
	$Player/Quit.disabled = false

func _on_continue_pressed():
	$Player.can_move = true
	$Player/Continue.visible = false
	$Player/Quit.visible = false
	$Player/Continue.disabled = true
	$Player/Quit.disabled = true

func _on_quit_pressed():
	Global.goto_title()

func _on_performance_closed():
	$Player/Performance.visible = false
	$Player.can_move = true
	
func show_performance(accuracy, map, new_high_score):
	$Player/Performance.visible = true
	$Player.can_move = false
	$Player/Performance.show_performance(accuracy, new_high_score, map)









