extends TextureButton


func _on_pressed() -> void:
	SoundManager.play()
	get_parent().queue_free()
