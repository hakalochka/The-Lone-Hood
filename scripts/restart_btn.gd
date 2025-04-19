extends TextureButton


func _on_pressed() -> void:
	get_tree().paused = false
	SoundManager.play()
	get_tree().reload_current_scene()
