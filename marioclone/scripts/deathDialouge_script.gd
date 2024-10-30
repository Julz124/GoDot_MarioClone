extends AcceptDialog
#signal dialogue_active

func _on_confirmed() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
	#dialogue_active.emit(true)

func _on_about_to_popup() -> void:
	Engine.time_scale = 0.5
	#dialogue_active.emit(false)
