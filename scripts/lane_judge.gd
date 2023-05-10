extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_lane_miss_body_entered(body):
	body.miss()


func _on_lane_good_body_entered(body):
	body.good()


func _on_lane_great_body_entered(body):
	body.great()


func _on_lane_perfect_body_entered(body):
	body.perfect()
