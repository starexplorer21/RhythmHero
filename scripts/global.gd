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

func load_save():
	if not FileAccess.file_exists(save_path):
		print("Error could not load save")
		return 
		
	loaded_save = FileAccess.open(save_path, FileAccess.READ_WRITE)
	dict = JSON.parse_string(loaded_save.get_as_text())
	unlocked_level2 = dict["unlocked_level2"]

func save():
	loaded_save.store_string(JSON.stringify(dict))

# Called when the node enters the scene tree for the first time.
func _ready():
	root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	load_save()

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
		if accuracy >= 70 and !dict[map]:
			dict[map] = true
			crutches += 1
			dict["crutch"] = crutches
			save()
			

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
