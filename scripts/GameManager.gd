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

var map_folder: String

var path
var song
var map
var metadata

var load_metadata
var meta_dict
var high_score

var map_dict
var note
var hold_start
var hold_inter
var hold_end
var end
var map_position = 0

var audio_position
var paused = false
var hitsound_player = AudioStreamPlayer.new()
var music_player
var perfects = 0
var greats = 0
var goods = 0
var misses = 0
var total_score = 0

var perfect
var great 
var good 
var miss

var combo = 0
var combo_max = 0

func assign_map(change_map, difficulty):
	map_folder = change_map
	path = "res://maps/"+map_folder+"/"
	song = path + "song.wav"
	if difficulty == "Easy":
		map = path + "easy.json"
	elif difficulty == "Normal": 
		map = path + "map.json"
	metadata = path + "metadata.json"

# Called when the node enters the scene tree for the first time.
func _ready():
	perfect = $Control/Perfect
	great = $Control/Great
	good = $Control/Good
	miss = $Control/Miss
	reset_all()
	load_map()
	note = preload("res://assets/Rhythm Game/note.tscn")
	hold_start = preload("res://assets/Rhythm Game/hold_note_start.tscn")
	hold_inter = preload("res://assets/Rhythm Game/hold_note_intermediate.tscn")
	hold_end = preload("res://assets/Rhythm Game/hold_note_end.tscn")
	end = preload("res://assets/Rhythm Game/game_end.tscn")
	music_player = AudioStreamPlayer.new()
	music_player.stream = load(song)
	add_child(music_player)
	await get_tree().create_timer(1.0).timeout
	if !paused:
		music_player.play()
	hitsound_player.stream = load("res://resources/normal-hitnormal.wav")
	add_child(hitsound_player)

func load_map():
	if not FileAccess.file_exists(map):
		print("Error could not load map")
		return 
	
	if not FileAccess.file_exists(metadata):
		print("Error could not load metadata")
		return 
	
	var load_file = FileAccess.open(map, FileAccess.READ)
	load_metadata = FileAccess.open(metadata, FileAccess.READ_WRITE)
	meta_dict = JSON.parse_string(load_metadata.get_as_text())
	high_score = meta_dict["high_score"]
	map_dict = JSON.parse_string(load_file.get_as_text())
	
func play_hit(judge):
	# First resets all the hit markers and then shows the next one
	reset_all()
	$Control/Combo.text = str(combo)
	for i in range(5):
		judge.modulate.a += 0.2
		await get_tree().create_timer(0.01).timeout
	for i in range(5):
		judge.modulate.a -= 0.2
		await get_tree().create_timer(0.01).timeout

func reset_all():
	perfect.modulate.a = 0
	great.modulate.a = 0
	good.modulate.a = 0
	miss.modulate.a = 0
		
func load_row():
	#this just makes sure we don't run off the end and crash
	if map_position < len(map_dict["lane1"]):
		# queues notes to be spawned
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
				cur_note.add_to_group("to_pause")
				cur_note.position.x = lane_x[i]
				cur_note.position.z = start
				total_score += 5
					
			elif read_note == 2:
				var cur_note = hold_start.instantiate()
				add_child(cur_note)
				cur_note.add_to_group("to_pause")
				cur_note.position.x = lane_x[i]
				cur_note.position.z = start
				total_score += 5
			
			elif read_note == 3:
				var cur_note = hold_inter.instantiate()
				add_child(cur_note)
				cur_note.add_to_group("to_pause")
				cur_note.position.x = lane_x[i]
				cur_note.position.z = start
			
			elif read_note == 4:
				var cur_note = hold_end.instantiate()
				add_child(cur_note)
				cur_note.add_to_group("to_pause")
				cur_note.position.x = lane_x[i]
				cur_note.position.z = start
				total_score += 5
			
			# If I read to end the game then I'll wait a bit to let the song end then end game. 
			elif read_note == 5:
				await get_tree().create_timer(1.3).timeout
				music_player.stop()
				var score = (perfects * 5.0) + (greats * 4.0) + (goods * 3.0)
				var accuracy = int((score/total_score) * 100)
				var show_high_score = false
				if high_score < accuracy:
					meta_dict["high_score"] = accuracy
					show_high_score = true
				load_metadata.store_string(JSON.stringify(meta_dict))
				Global.goto_navigation(accuracy, map_folder, show_high_score, true)
		
func judge_lane(l):
	var lane = []
	var lane_is_held = false
	var laneHit = ""
	# if statements to make it more reusable. 
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
	
	# Some defensive code to clean up any freed notes that haven't been removed
	var lane_pointer = lane.size()-1
	if lane.size()-1 < 0:
		lane_pointer = -1
	elif !is_instance_valid(lane[lane_pointer]):
		lane.pop_back()
		lane_pointer -= 1

	# More defensive code to check if we will run with a negative index
	if !lane.is_empty() && lane_pointer >= 0:
		# Check if the current lane has been tapped
		if Input.is_action_just_pressed(laneHit):
			calc_judge(lane[lane_pointer].get_judge())
			lane[lane_pointer].hit()
			hitsound_player.play()
			if lane[lane_pointer].get_type() == "hold_start":
				lane_is_held = true
			else:
				# We don't pop out the hold note if we're holding
				lane.pop_back()
				
		elif Input.is_action_just_released(laneHit) && lane_is_held:
			calc_judge(lane[lane_pointer].get_judge())
			# More defensive code to prevent crashing
			if lane[lane_pointer].get_type() != "normal":
				lane[lane_pointer].release()
			lane.pop_back()
			lane_is_held = false
			
	# updates the state of each lane because booleans don't save references, instead they make
	# a new copy, so we store the current state. 
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
		combo += 1
		if combo > combo_max:
			combo_max = combo
		perfects += 1
		play_hit(perfect)
	elif judgement == "Great":
		combo += 1
		if combo > combo_max:
			combo_max = combo
		greats += 1
		play_hit(great)
	elif judgement == "Good":
		goods += 1
		play_hit(good)
		combo = 0
	elif judgement == "Miss":
		misses += 1
		play_hit(miss)
		combo = 0

func _physics_process(delta):
	judge_lane(1)
	judge_lane(2)
	judge_lane(3)
	judge_lane(4)
	load_row()
	
	# Allows escape to be used as a pause button. 
	if Input.is_action_just_pressed("ui_cancel"):
		_on_pause_pressed()

	# incrementes the map position every frame. 
	map_position += 1
	

func _on_lane_queue_1_body_entered(body):
	lane1.push_front(body)
	body.judge = "Miss"

func _on_lane_queue_2_body_entered(body):
	lane2.push_front(body)
	body.judge = "Miss"

func _on_lane_queue_3_body_entered(body):
	lane3.push_front(body)
	body.judge = "Miss"

func _on_lane_queue_4_body_entered(body):
	lane4.push_front(body)
	body.judge = "Miss"
	
# This section checks for leaked notes. 

func _on_lane_judge_1_just_missed():
	misses += 1
	calc_judge("Miss")

func _on_lane_judge_2_just_missed():
	misses += 1
	calc_judge("Miss")

func _on_lane_judge_3_just_missed():
	misses += 1
	calc_judge("Miss")

func _on_lane_judge_4_just_missed():
	misses += 1
	calc_judge("Miss")

func _on_pause_pressed():
	get_tree().call_group("to_pause", "stop")
	paused = true
	$Control/Continue.visible = true
	$Control/Restart.visible = true
	$Control/Quit.visible = true
	$Control/Continue.disabled = false
	$Control/Restart.disabled = false
	$Control/Quit.disabled = false
	

func _on_restart_pressed():
	Global.goto_game(map_folder)
	
func stop():
	set_physics_process(false)
	audio_position = music_player.get_playback_position()
	music_player.stop()
	
func resume():
	set_physics_process(true)
	music_player.play(audio_position)
	
func _on_continue_pressed():
	get_tree().call_group("to_pause", "resume")
	paused = false
	$Control/Continue.visible = false
	$Control/Restart.visible = false
	$Control/Quit.visible = false
	$Control/Continue.disabled = true
	$Control/Restart.disabled = true
	$Control/Quit.disabled = true


func _on_quit_pressed():
	Global.goto_navigation(0.0, map_folder, false, false)
