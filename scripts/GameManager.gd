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

var map_dict
var note
var hold_start
var hold_inter
var hold_end
var end
var map_position = 0

var bpm = 117
var divisions = 32
var time = 120.0
var hitsound_player = AudioStreamPlayer.new()
var perfects = 0
var greats = 0
var goods = 0
var misses = 0
var total_score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	load_map()
	note = preload("res://assets/Rhythm Game/note.tscn")
	hold_start = preload("res://assets/Rhythm Game/hold_note_start.tscn")
	hold_inter = preload("res://assets/Rhythm Game/hold_note_intermediate.tscn")
	hold_end = preload("res://assets/Rhythm Game/hold_note_end.tscn")
	end = preload("res://assets/Rhythm Game/game_end.tscn")
	var music_player = AudioStreamPlayer.new()
	music_player.stream = load(song)
	add_child(music_player)
	await get_tree().create_timer(1.1).timeout
	music_player.play()
	hitsound_player.stream = load("res://resources/normal-hitnormal.wav")
	add_child(hitsound_player)

func load_map():
	if not FileAccess.file_exists(map):
		print("Error could not load map")
		return 
		
	var load_file = FileAccess.open(map, FileAccess.READ)
	map_dict = JSON.parse_string(load_file.get_as_text())
	
func load_row():
	if map_position < len(map_dict["lane1"]):
		var row_notes = []
		row_notes.push_back(map_dict["lane1"][map_position])
		row_notes.push_back(map_dict["lane2"][map_position])
		row_notes.push_back(map_dict["lane3"][map_position])
		row_notes.push_back(map_dict["lane4"][map_position])
		for i in range(4):
			var read_note = row_notes[i]
			if read_note == 1:
				var cur_note = note.instantiate()
				add_child(cur_note)
				cur_note.position.x = lane_x[i]
				cur_note.position.z = start
				total_score += 5
					
			elif read_note == 2:
				var cur_note = hold_start.instantiate()
				add_child(cur_note)
				cur_note.position.x = lane_x[i]
				cur_note.position.z = start
				total_score += 5
			
			elif read_note == 3:
				var cur_note = hold_inter.instantiate()
				add_child(cur_note)
				cur_note.position.x = lane_x[i]
				cur_note.position.z = start
			
			elif read_note == 4:
				var cur_note = hold_end.instantiate()
				add_child(cur_note)
				cur_note.position.x = lane_x[i]
				cur_note.position.z = start
				total_score += 5
				
			elif read_note == 5:
				await get_tree().create_timer(1.3).timeout
				var score = (perfects * 5.0) + (greats * 4.0) + (goods * 3.0) + (misses * 2.0)
				print(score/total_score)
				queue_free()
		
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
	elif l == 5:
		queue_free()
		
	var lane_pointer = lane.size()-1
	if lane.size()-1 < 0:
		lane_pointer = -1
	elif !is_instance_valid(lane[lane_pointer]):
		lane.pop_back()
		lane_pointer -= 1

	if !lane.is_empty() && lane_pointer >= 0:
		$Control/RichTextLabel.text = ""
		if Input.is_action_just_pressed(laneHit):
			$Control/RichTextLabel.text = lane[lane_pointer].get_judge() #replace with showing judgement later
			calc_judge(lane[lane_pointer].get_judge())
			lane[lane_pointer].hit()
			hitsound_player.play()
			if lane[lane_pointer].get_type() == "hold_start":
				lane_is_held = true
			else:
				lane.pop_back()
				
		if Input.is_action_just_released(laneHit) && lane_is_held:
			$Control/RichTextLabel.text = lane[lane_pointer].get_judge()
			calc_judge(lane[lane_pointer].get_judge())
			lane[lane_pointer].release()
			lane.pop_back()
			lane_is_held = false
			
	if l == 1:
		lane1_is_held = lane_is_held
	elif l == 2:
		lane2_is_held = lane_is_held
	elif l == 3:
		lane3_is_held = lane_is_held
	elif l == 4:
		lane4_is_held = lane_is_held

func calc_judge(judgement):
	if judgement == "Perfect":
		perfects += 1
	elif judgement == "Great":
		greats += 1
	elif judgement == "Good":
		goods += 1
	elif judgement == "Miss":
		misses += 1

func _physics_process(delta):
	judge_lane(1)
	judge_lane(2)
	judge_lane(3)
	judge_lane(4)
	load_row()
	map_position += 1
	

func _on_lane_queue_1_body_entered(body):
	lane1.push_front(body)


func _on_lane_queue_2_body_entered(body):
	lane2.push_front(body)


func _on_lane_queue_3_body_entered(body):
	lane3.push_front(body)


func _on_lane_queue_4_body_entered(body):
	lane4.push_front(body)
