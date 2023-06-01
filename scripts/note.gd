extends CharacterBody3D

#Already tested speed: 0.172666
var move = Vector3(0,0,0.36)
var judge = "Miss"
	
func _physics_process(delta):
	move_and_collide(move)
	
func hit():
	$MeshInstance3D.visible = false
	$MeshInstance3D2.visible = true
	await get_tree().create_timer(0.02).timeout
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

func stop():
	set_physics_process(false)
	
func resume():
	set_physics_process(true)
