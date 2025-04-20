extends Control
@onready var canvas_layer: CanvasLayer = get_node("/root/level_init/CanvasLayer")

func _on_resume_btn_pressed() -> void:
	GameManager.show_mouse(false)
	SoundManager.play()
	get_tree().paused = false
	queue_free()



func _on_options_bts_pressed() -> void:
	SoundManager.play()
	var options_menu = preload("res://scenes/options_menu.tscn").instantiate()
	canvas_layer.add_child(options_menu)
