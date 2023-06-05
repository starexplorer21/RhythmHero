extends Control

signal closed

var metadata_dict

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_close_pressed():
	emit_signal("closed")

func load_file(metadata):
	if not FileAccess.file_exists(metadata):
		print("Error could not load map")
		return 
		
	var load_file = FileAccess.open(metadata, FileAccess.READ)
	metadata_dict = JSON.parse_string(load_file.get_as_text())


func load_assets(song):
	var path = "res://maps/"+song+"/"
	load_file(path + "metadata.json")
	$Cover.texture = load(path + "cover.png")
	$Song_name.text = song
	
func show_performance(accuracy, new_high_score, song):
	$High_score.visible = new_high_score
	$Score.text = "Accuracy:" + str(accuracy) + "%"
	load_assets(song)
