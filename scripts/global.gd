extends Node

var current_scene
var map
var root
var difficulty = "Normal"
var unlocked_level2 = true

# Called when the node enters the scene tree for the first time.
func _ready():
	root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_navigation(accuracy, map, new_high_score, show_performance):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	
	if map == "Paradise" and accuracy > 70:
		unlocked_level2 = true

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