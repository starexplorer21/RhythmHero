extends Control

var slide_num = 1

signal finished

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func transition(from, to):
	for i in range(10):
		from.modulate.a -= 0.1
		await get_tree().create_timer(0.05).timeout
		
	for i in range(10):
		to.modulate.a += 0.1
		await get_tree().create_timer(0.05).timeout
		
func _on_next_pressed():
	if slide_num == 10:
		visible = false
		$Next.disabled = true
		$Back.disabled = true
		emit_signal("finished")
	else:
		var from = "Slide" + str(slide_num)
		slide_num += 1
		var to = "Slide" + str(slide_num)
		transition(get_node(from), get_node(to))
		

func _on_back_pressed():
	if slide_num != 1:
		var from = "Slide" + str(slide_num)
		slide_num -= 1
		var to = "Slide" + str(slide_num)
		transition(get_node(from), get_node(to))
		
func activate():
	visible = true
	$Next.disabled = false
	$Back.disabled = false
