extends Control

func _process(delta: float) -> void:
	var viewport_width = get_viewport().get_visible_rect().size.x
	position.x = viewport_width / 2
