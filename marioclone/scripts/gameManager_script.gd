extends Node

const offset_from_camera = Vector2(-120, -60)
const smoothing_speed_x = 6.0
const smoothing_speed_y = 4.5

@onready var score_label: Label = $score_label
@onready var player_camera: Camera2D = %player_Camera

var score = 0

func increase_score():
	score += 1
	score_label.text = "Coins: " + str(score)

func _process(delta):
	var camera = get_viewport().get_camera_2d()
	if player_camera:
		var target_position = player_camera.global_position + offset_from_camera
		if target_position.y > (120 + offset_from_camera.y):
			target_position = Vector2((player_camera.global_position.x - 120), -20)
		score_label.global_position.y = lerp(score_label.global_position.y, target_position.y, smoothing_speed_y * delta)
		score_label.global_position.x = lerp(score_label.global_position.x, target_position.x, smoothing_speed_x * delta)
		
