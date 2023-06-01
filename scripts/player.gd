extends CharacterBody2D

var speed = 2.5
var lastdir: Vector2 = Vector2.ZERO
var can_move = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("down_idle")

func _physics_process(delta):
	if can_move:	
		var dir = Vector2.ZERO
		
		if Input.is_action_pressed("moveup"):
			dir.y = -1
		elif Input.is_action_pressed("movedown"):
			dir.y = 1	
		elif Input.is_action_pressed("moveleft"):
			dir.x = -1	
		elif Input.is_action_pressed("moveright"):
			dir.x = 1		

		move_and_collide(dir * speed)
		
		if dir.length() > 0:
			if dir.x > 0:
				$AnimatedSprite2D.play("side_walk")
				$AnimatedSprite2D.flip_h = false
			elif dir.x < 0:
				$AnimatedSprite2D.play("side_walk")
				$AnimatedSprite2D.flip_h = true
			elif dir.y > 0:
				$AnimatedSprite2D.play("down_walk")
				$AnimatedSprite2D.flip_h = false
			elif dir.y < 0:
				$AnimatedSprite2D.play("up_walk")
				$AnimatedSprite2D.flip_h = false
		else:
			if lastdir.x > 0:
				$AnimatedSprite2D.play("side_idle")
				$AnimatedSprite2D.flip_h = false
			elif lastdir.x < 0:
				$AnimatedSprite2D.play("side_idle")
				$AnimatedSprite2D.flip_h = true
			elif lastdir.y > 0:
				$AnimatedSprite2D.play("down_idle")
				$AnimatedSprite2D.flip_h = false
			elif lastdir.y < 0:
				$AnimatedSprite2D.play("up_idle")
				$AnimatedSprite2D.flip_h = false 
		
		lastdir = dir

