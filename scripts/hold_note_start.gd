extends CharacterBody3D


var move = Vector3(0,0,0.36)
var judge = "Miss"
var playing_animation = false

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
	if !playing_animation: 
		judge = "Miss"
		queue_free()

func good():
	if !playing_animation: 
		judge = "Good"

func great():
	if !playing_animation: 
		judge = "Great"
	
func perfect():
	if !playing_animation: 
		judge = "Perfect"
	
func get_judge():
	return judge
	
func release():
	playing_animation = true
	$MeshInstance3D.visible = false
	$MeshInstance3D2.visible = true
	await get_tree().create_timer(0.02).timeout
	queue_free()
	
func get_type():
	return "hold_start"
