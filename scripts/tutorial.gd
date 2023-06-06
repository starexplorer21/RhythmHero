extends Node2D


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
