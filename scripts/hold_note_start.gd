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
	$MeshInstance3D.visible = false
	hold_on()
	
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
	move = Vector3.ZERO
	playing_animation = true
	$MeshInstance3D.visible = false
	hold_off()
	
	
func hold_on():
	var mesh = $MeshInstance3D2
	for i in range(5):
		mesh.transparency -= 0.2
		await get_tree().create_timer(0.01).timeout
	
func hold_off():
	var mesh = $MeshInstance3D2
	for i in range(5):
		mesh.transparency += 0.2
		await get_tree().create_timer(0.01).timeout
	queue_free()
func get_type():
	return "hold_start"
	
func stop():
	set_physics_process(false)
	
func resume():
	set_physics_process(true)
