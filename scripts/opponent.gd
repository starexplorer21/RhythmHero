extends Node2D

@export var direction : int

var speed = 2.5
var lastdir: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == 1:
		$AnimatedSprite2D.play("down_idle")
	elif direction == 2:
		$AnimatedSprite2D.play("side_idle")
		$AnimatedSprite2D.flip_h = true
	elif direction == 3:
		$AnimatedSprite2D.play("side_idle")
	elif direction == 4:
		$AnimatedSprite2D.play("up_idle")


