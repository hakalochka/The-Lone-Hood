extends TextureButton


func _on_pressed() -> void:
	SoundManager.play()
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")
