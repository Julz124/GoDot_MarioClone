extends Area2D

@onready var death_dialogue: AcceptDialog = %deathDialogue

func _on_body_entered(body: Node2D) -> void:
	death_dialogue.popup()
