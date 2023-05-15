extends CharacterBody3D

var move = Vector3(0,0,0.178)
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
	queue_free()
	
func miss():
	judge = "Miss"
	queue_free()

func good():
	judge = "Good"

func great():
	judge = "Great"
	
func perfect():
	judge = "Perfect"
	
func get_judge():
	return judge

func get_type():
	return "normal"
