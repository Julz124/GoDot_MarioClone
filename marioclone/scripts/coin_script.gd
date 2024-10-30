extends Area2D

@onready var game_manager: Node = %gameManager

var hover_amplitude = 0.25
var hover_speed = 5.0

func _process(delta):
	position.y += hover_amplitude * sin(Time.get_ticks_msec() * hover_speed / 1000.0)

func _on_body_entered(body: Node2D) -> void:
	game_manager.increase_score()
	queue_free()
