extends Node3D

var start = -19.5

enum lanes {lane1, lane2, lane3, lane4}

const lane_x = {
	lanes.lane1 : -2.95,
	lanes.lane2 : -0.9,
	lanes.lane3 : 1.05,
	lanes.lane4 : 3
	}

var lane1 = []
var lane1_is_held = false

var lane2 = []
var lane2_is_held = false

var lane3 = []
var lane3_is_held = false

var lane4 = []
var lane4_is_held = false

var path = "res://maps/"+Global.map+"/"
var song = path + "song.wav"
var map = path + "map.json"

var bpm = 117

# Called when the node enters the scene tree for the first time.
func _ready():
	load_song()
	var music_player = AudioStreamPlayer.new()
	await get_tree().create_timer(1).timeout
	music_player.stream = load(song)
	add_child(music_player)
	music_player.play()
	
	
func load_lane(dict, lane):
	var note = preload("res://assets/note.tscn")
	var hold_start = preload("res://assets/hold_note_start.tscn")
	var hold_inter = preload("res://assets/hold_note_intermediate.tscn")
	var hold_end = preload("res://assets/hold_note_end.tscn")
	var lane_notes = dict[lanes.keys()[lane]]
	var note_start = start
	for i in range(lane_notes.size()):
		
		if lane_notes[i] == 1:
			var cur_note = note.instantiate()
			add_child(cur_note)
			var move_by = (((bpm/60.0)/16.0) * 19.5)
			cur_note.position.x = lane_x[lane]
			cur_note.position.z = note_start - move_by
				
		elif lane_notes[i] == 2:
			var cur_note = hold_start.instantiate()
			add_child(cur_note)
			var move_by = (((bpm/60.0)/16.0) * 19.5)
			cur_note.position.x = lane_x[lane]
			cur_note.position.z = note_start - move_by
		
		elif lane_notes[i] == 3:
			var cur_note = hold_inter.instantiate()
			add_child(cur_note)
			var move_by = (((bpm/60.0)/16.0) * 19.5)
			cur_note.position.x = lane_x[lane]
			cur_note.position.z = note_start - move_by
		
		elif lane_notes[i] == 4:
			var cur_note = hold_end.instantiate()
			add_child(cur_note)
			var move_by = (((bpm/60.0)/16.0) * 19.5)
			cur_note.position.x = lane_x[lane]
			cur_note.position.z = note_start - move_by
			
		note_start -= (((bpm/60.0)/32.0) * 19.5)

func load_song():
	if not FileAccess.file_exists(map):
		print("Error could not load map")
		return 
		
	var load_file = FileAccess.open(map, FileAccess.READ)
	var dict = JSON.parse_string(load_file.get_as_text())
	load_lane(dict, lanes.lane1)
	load_lane(dict, lanes.lane2)
	load_lane(dict, lanes.lane3)
	load_lane(dict, lanes.lane4)
	
	
func save():
	var dict = {}
	dict["song_name"] = $/root/Global.map
	
	dict["lane1"] = [0,1,2,3,4]
	dict["lane2"] = [0,1,2,3,4]
	dict["lane3"] = [0,1,2,3,4]
	dict["lane4"] = [0,1,2,3,4]
	
	var save_file = FileAccess.open(map, FileAccess.WRITE)
	save_file.store_string(JSON.stringify(dict))
	print(dict)
	print("Saved")

	
func judge_lane(l):
	var lane = []
	var lane_is_held = false
	var laneHit = ""
	if l == 1:
		lane = lane1
		lane_is_held = lane1_is_held
		laneHit = "lane1"
	elif l == 2:
		lane = lane2
		lane_is_held = lane2_is_held
		laneHit = "lane2"
	elif l == 3:
		lane = lane3
		lane_is_held = lane3_is_held
		laneHit = "lane3"
	elif l == 4:
		lane = lane4
		lane_is_held = lane4_is_held
		laneHit = "lane4"
		
	var lane_pointer = lane.size()-1
	if lane.size()-1 < 0:
		lane_pointer = 0
	if !lane.is_empty():
		if !is_instance_valid(lane[lane_pointer]):
			lane.pop_back()
			
		if Input.is_action_just_pressed(laneHit):
			print(lane[lane_pointer].get_judge()) #replace with showing judgement later
			lane[lane_pointer].hit()
			if lane[lane_pointer].get_type() == "hold_start":
				lane_is_held = true
			else:
				print(lane)
				lane.pop_back()
				print(lane)
				
		if Input.is_action_just_released(laneHit) && lane_is_held:
			print(lane[lane_pointer].get_judge())
			lane[lane_pointer].release()
			lane.pop_back()
			lane_is_held = false
			print("released")
			print(lane)
	if l == 1:
		lane1_is_held = lane_is_held
	elif l == 2:
		lane2_is_held = lane_is_held
	elif l == 3:
		lane3_is_held = lane_is_held
	elif l == 4:
		lane4_is_held = lane_is_held


func _physics_process(delta):
	judge_lane(1)
	judge_lane(2)
	judge_lane(3)
	judge_lane(4)
	

func _on_lane_queue_1_body_entered(body):
	lane1.push_front(body)


func _on_lane_queue_2_body_entered(body):
	lane2.push_front(body)


func _on_lane_queue_3_body_entered(body):
	lane3.push_front(body)


func _on_lane_queue_4_body_entered(body):
	lane4.push_front(body)
