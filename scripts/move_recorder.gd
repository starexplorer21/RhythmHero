extends Node3D

var map_folder = "Don't Fight The Music"

var bpm = 117
#var time_between_notes = ((30.0)/bpm)/32.0
var timer = 0

var path = "res://maps/"+map_folder+"/"
var song = path + "song.wav"
var map = path + "map.json"

var lane1 = []
var queued_input_lane_1 = 0
var is_lane_1_held = false

var lane2 = []
var queued_input_lane_2 = 0
var is_lane_2_held = false

var lane3 = []
var queued_input_lane_3 = 0
var is_lane_3_held = false

var lane4 = []
var queued_input_lane_4 = 0
var is_lane_4_held = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var music_player = AudioStreamPlayer.new()
	music_player.stream = load(song)
	add_child(music_player)
	music_player.play()

func save():
	var dict = {}
	dict["song_name"] = $/root/Global.map
	lane1.push_back(5)
	lane2.push_back(5)
	lane3.push_back(5)
	lane4.push_back(5)
	dict["lane1"] = lane1
	dict["lane2"] = lane2
	dict["lane3"] = lane3
	dict["lane4"] = lane4
	
	var save_file = FileAccess.open(map, FileAccess.WRITE)
	save_file.store_string(JSON.stringify(dict))
	print(dict)
	print("Saved")

func _physics_process(delta):
	lane1.push_back(queued_input_lane_1)
	if is_lane_1_held:
		queued_input_lane_1 = 3
	else:
		queued_input_lane_1 = 0
		
	lane2.push_back(queued_input_lane_2)
	if is_lane_2_held:
		queued_input_lane_2 = 3
	else:
		queued_input_lane_2 = 0
		
		
	lane3.push_back(queued_input_lane_3)
	if is_lane_3_held:
		queued_input_lane_3 = 3
	else:
		queued_input_lane_3 = 0
		
		
	lane4.push_back(queued_input_lane_4)
	if is_lane_4_held:
		queued_input_lane_4 = 3
	else:
		queued_input_lane_4 = 0
		
	
	if Input.is_action_just_pressed("lane1") and !is_lane_1_held:
		queued_input_lane_1 = 1
	
	if Input.is_action_just_pressed("editor_lane1_hold"):
		queued_input_lane_1 = 2
		is_lane_1_held = true
		
	if Input.is_action_just_released("editor_lane1_hold"):
		queued_input_lane_1 = 4
		is_lane_1_held = false
		
	if Input.is_action_just_pressed("lane2") and !is_lane_2_held:
		queued_input_lane_2 = 1
	
	if Input.is_action_just_pressed("editor_lane2_hold"):
		queued_input_lane_2 = 2
		is_lane_2_held = true
		
	if Input.is_action_just_released("editor_lane2_hold"):
		queued_input_lane_2 = 4
		is_lane_2_held = false
		
	if Input.is_action_just_pressed("lane3") and !is_lane_3_held:
		queued_input_lane_3 = 1
	
	if Input.is_action_just_pressed("editor_lane3_hold"):
		queued_input_lane_3 = 2
		is_lane_3_held = true
		
	if Input.is_action_just_released("editor_lane3_hold"):
		queued_input_lane_3 = 4
		is_lane_3_held = false
	
	if Input.is_action_just_pressed("lane4") and !is_lane_4_held:
		queued_input_lane_4 = 1
	
	if Input.is_action_just_pressed("editor_lane4_hold"):
		queued_input_lane_4 = 2
		is_lane_4_held = true
		
	if Input.is_action_just_released("editor_lane4_hold"):
		queued_input_lane_4 = 4
		is_lane_4_held = false
		
	if Input.is_action_just_pressed("ui_cancel"):
		save()
