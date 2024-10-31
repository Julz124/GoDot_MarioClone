extends AcceptDialog

func _on_confirmed() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()

func _on_about_to_popup() -> void:
	Engine.time_scale = 0.5

func _on_player_dead() -> void:
	self.popup()
