extends Node2D

var song_name

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Allows escape to be used as a pause button. 
	if Input.is_action_just_pressed("ui_cancel"):
		_on_pause_pressed()
	
func _on_show_tutorial_body_entered(body):
	$Player/Tutorial_Slides.activate()
	$Player.can_move = false

func _on_tutorial_slides_finished():
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
	Global.goto_title()

func _on_opponent_hitbox_body_entered(body):
	song_name = "Gunjo Sanka"
	$Player/Song_Select.load_assets(song_name)
	$Player/Song_Select.visible = true
	$Player.can_move = false

func _on_song_select_closed():
	$Player/Song_Select.visible = false
	$Player.can_move = true
	
func _on_song_select_play():
	Global.goto_game(song_name)


func _on_secret_hitbox_body_entered(body):
	song_name = "Capybara"
	$Player/Song_Select.load_assets(song_name)
	$Player/Song_Select.visible = true
	$Player.can_move = false
