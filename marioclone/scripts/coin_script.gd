extends Area2D

var hover_amplitude = 0.25
var hover_speed = 5.0

func _process(delta):
	position.y += hover_amplitude * sin(Time.get_ticks_msec() * hover_speed / 1000.0)


func _on_body_entered(body: Node2D) -> void:
	queue_free()
