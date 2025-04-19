extends Control




func _on_resume_btn_pressed() -> void:
	get_tree().paused = false
	queue_free()
