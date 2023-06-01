extends CharacterBody3D

#0.36 for 1 second to pass the entirety of the screen
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
	queue_free()
	
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
		hit()
	
func get_judge():
	return judge

func release():
	playing_animation = true
	$MeshInstance3D.visible = false
	$MeshInstance3D2.visible = true
	await get_tree().create_timer(0.02).timeout
	queue_free()
	
func get_type():
	return "hold_end"


func _on_area_3d_body_entered(body):
	if body.get_judge() == "hold_start":
		release()
		
func stop():
	set_physics_process(false)
	
func resume():
	set_physics_process(true)
