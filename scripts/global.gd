extends Node

var current_scene
var map
var root
var difficulty = "Normal"
var unlocked_level2
var dict
var save_path = "res://save_file.json"
var crutches
var loaded_save
var music_position
var music_player

func load_save():
	if not FileAccess.file_exists(save_path):
		print("Error could not load save")
		return 
		
	loaded_save = FileAccess.open(save_path, FileAccess.READ)
	dict = JSON.parse_string(loaded_save.get_as_text())
	crutches = dict["crutches"]
	unlocked_level2 = (crutches >=7)
	loaded_save.close()

func save():
	loaded_save = FileAccess.open(save_path, FileAccess.READ_WRITE)
	loaded_save.store_string(JSON.stringify(dict))
	loaded_save.close()

# Called when the node enters the scene tree for the first time.
func _ready():
	root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	load_save()
	# This is the route 1 theme from Pokemon Sun and Moon and its remakes.
	music_player = AudioStreamPlayer.new()
	music_player.stream = load("res://resources/bgm.wav")
	music_player.autoplay = true
	add_child(music_player)
	music_player.play()

func goto_navigation(accuracy, map, new_high_score, show_performance):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	
	# These songs don't count
	if map != "Gunjo Sanka" and map != "Capybara":
		# I'd like to do it backwards but since you can't really erase characters,
		# and false is longer than true, then this guarentees it works unless you manually
		# hack the save file to break.
		if accuracy >= 70 and dict[map]:
			dict[map] = false
			crutches += 1
			dict["crutches"] = crutches
			save()
	music_player.play()		

	call_deferred("_deferred_goto_navigation", accuracy, map, new_high_score, show_performance)

func _deferred_goto_navigation(accuracy, map, new_high_score, show_performance):
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load("res://assets/navigation.tscn")

	# Instance the new scene.
	current_scene = s.instantiate()
	
	if show_performance:
		current_scene.show_performance(accuracy, map, new_high_score)
	
	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene

func goto_game(map):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	music_player.stop()
	call_deferred("_deferred_goto_game",map)

func _deferred_goto_game(map):
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load("res://assets/Rhythm Game/RhythmGame.tscn")

	# Instance the new scene.
	current_scene = s.instantiate()
	
	current_scene.assign_map(map, difficulty)

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
	
func goto_title():
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_title")

func _deferred_goto_title():
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load("res://assets/title.tscn")

	# Instance the new scene.
	current_scene = s.instantiate()
	
	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
	
func goto_tutorial():
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_tutorial")

func _deferred_goto_tutorial():
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load("res://assets/tutorial.tscn")

	# Instance the new scene.
	current_scene = s.instantiate()
	
	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
