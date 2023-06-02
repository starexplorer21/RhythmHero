extends Control

signal play
signal closed

var metadata_dict

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	emit_signal("play")
	
	
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
	var artist = "res://maps/"+song+"/"
	$Artist.text = "Artist: " +  metadata_dict["artist"]
	$Song_name.text = song
	var suggested = metadata_dict["suggested"]
	if suggested != "none":
		$Suggested.text = "Suggester(s): "+ suggested
	else:
		$Suggested.text = ""
	$High_Score.text = "High Score: " + str(metadata_dict["high_score"]) + "%"


func _on_button_2_pressed():
	emit_signal("closed")
