extends StaticBody2D

const SPEED = 50.0
@onready var ball = $"../Ball"

var ball_pos_y


func _process(delta):
	#if Input.is_action_pressed("move_up"):
		#position.y -= SPEED * delta
	#if Input.is_action_pressed("move_down"):
		#position.y += SPEED * delta
	if ball != null:
		ball_pos_y = ball.position.y
		position.y += SPEED * delta



