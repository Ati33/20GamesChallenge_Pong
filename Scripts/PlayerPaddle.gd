extends StaticBody2D

const SPEED = 50.0
var window_height : int
var paddle_height : int


func _ready():
	window_height = 54
	paddle_height = $ColorRect.get_size().y
	print(window_height)


func _process(delta):
	if Input.is_action_pressed("ui_up"):
		position.y -= SPEED * delta
	if Input.is_action_pressed("ui_down"):
		position.y += SPEED * delta

	position.y = clamp(position.y, paddle_height / 2, window_height - paddle_height / 2)


