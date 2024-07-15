extends CharacterBody2D

const START_SPEED = 30
var speed = START_SPEED
const ACCEL = 2
var dir : Vector2
@onready var opp_score_text = $"../OppSideScoreArea/CanvasLayer/OppScore"
@onready var player_score_text = $"../OppSideScoreArea/CanvasLayer/PlayerScore"
var player_score = 0
var opp_score = 0
const MAX_Y_VECTOR = 1
var paddle_height

func _ready():
	paddle_height = $"../Player/ColorRect".get_size().y


func _physics_process(delta):
	var collision = move_and_collide(dir * speed * delta)
	var collider
	if collision:
		collider = collision.get_collider()
		if collider == $"../Player" or collider == $"../Opponent":
			dir = _new_direction(collider)
			speed += ACCEL
		elif collider == $"../CeilingAndFloor":
			dir = dir.bounce(collision.get_normal())

func _new_direction(collider):
	var ball_y = position.y
	var pad_y = collider.position.y
	var distance = ball_y - pad_y
	var new_dir = Vector2()
	#flip after bounce
	if dir.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
	new_dir.y = (distance / paddle_height / 2) * MAX_Y_VECTOR
	return new_dir.normalized()

func _new_ball():
	#randomize start position direction
	position.x = 48
	position.y = randi_range(2, 52)
	speed = START_SPEED
	
	dir = _random_direction()


func _random_direction():
	var new_dir = Vector2()
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(-1, 1)
	return new_dir.normalized()


func _on_area_2d_area_entered(area):
	if area == $"../PlayerSideScoreArea":
		opp_score += 1
		opp_score_text.text = str(opp_score)
	elif area == $"../OppSideScoreArea":
		player_score += 1
		player_score_text.text = str(player_score)
	$"../Timer".start()


func _on_timer_timeout():
	_new_ball()
