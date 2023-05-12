extends Node3D

var lane1X = -2.95

var lane2X = -0.9

var lane3X = 1.05

var lane4X = 3

var lane1 = []
var lane1_is_held = false

var lane2 = []
var lane2_is_held = false

var lane3 = []
var lane3_is_held = false

var lane4 = []
var lane4_is_held = false

var path = "res:/maps/"+"Awake Now"+"/"
var song = "path" + "song.mp3"
var map = "path" + "map.json"

# Called when the node enters the scene tree for the first time.
func _ready():
	var music_player = AudioStreamPlayer.new()
	music_player.stream = load(song)
	add_child(music_player)
	music_player.play()
	load_song()

func load_song():
	if not FileAccess.file_exists(map):
		print("Error could not load map")
		return 
		
	var load_file = FileAccess.open(map, FileAccess.READ)
	var dict = JSON.parse_string(load_file.get_as_text())
	print(dict)
	
	
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
			print("hi")
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
	




