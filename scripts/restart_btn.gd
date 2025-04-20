extends TextureButton


func _on_pressed() -> void:
	get_tree().paused = false
	SoundManager.play()
	GameManager.stars = 0
	get_tree().reload_current_scene()
