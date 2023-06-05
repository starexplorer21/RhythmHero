extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_show_tutorial_body_entered(body):
	print("hi")
	$Player/Tutorial_Slides.activate()
	$Player.can_move = false

func _on_tutorial_slides_finished():
	$Player.can_move = true
