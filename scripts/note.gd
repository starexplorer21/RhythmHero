extends CharacterBody3D

#Already tested speed: 0.172666
var move = Vector3(0,0,0.36)
var judge = "Miss"
	
func _physics_process(delta):
	move_and_collide(move)
	
func hit():
	move = Vector3.ZERO
	$MeshInstance3D.visible = false
	hit_effect()
	
func hit_effect():
	var mesh = $MeshInstance3D2
	for i in range(5):
		mesh.transparency -= 0.2
		await get_tree().create_timer(0.01).timeout
	for i in range(5):
		mesh.transparency += 0.2
		await get_tree().create_timer(0.01).timeout
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
