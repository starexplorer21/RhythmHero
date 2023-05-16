extends CharacterBody3D

#0.36 for 1 second to pass the entirety of the screen
var move = Vector3(0,0,0.172666)
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

func good():
	judge = "Good"

func great():
	judge = "Great"
	
func perfect():
	judge = "Perfect"
	hit()
	
func get_judge():
	return judge

func release():
	queue_free()
	
func get_type():
	return "hold_end"


func _on_area_3d_body_entered(body):
	if body.get_judge() == "hold_start":
		release()
