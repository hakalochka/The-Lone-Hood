extends Control

func _on_resume_btn_pressed() -> void:
	SoundManager.play()
	get_tree().paused = false
	queue_free()
