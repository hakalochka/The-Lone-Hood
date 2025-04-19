extends TextureButton



func _on_pressed() -> void:
	get_tree().paused = false
	SoundManager.play()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
