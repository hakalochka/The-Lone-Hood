extends TextureButton


func _on_pressed() -> void:
	SoundManager.play()
	var option_menu = preload("res://scenes/options_menu.tscn").instantiate()
	get_parent().add_child(option_menu)
	
