extends CharacterBody3D


var move = Vector3(0,0,0.36)
var judge = "Miss"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	move_and_collide(move)
	
	
func hit():
	move = Vector3.ZERO
	
func miss():
	judge = "Miss"

func good():
	judge = "Good"

func great():
	judge = "Great"
	
func perfect():
	judge = "Perfect"
	
func get_judge():
	return judge
	
func release():
	queue_free()
	
func get_type():
	return "hold_start"
