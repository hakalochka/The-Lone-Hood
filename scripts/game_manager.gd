extends Node

signal healthCheck

var stars: int = 0
var can_restore: bool = false



func stars_update():
	stars += 1
	print(stars)

func health_check():
	healthCheck.emit()

func can_restore_health() -> bool:
	return can_restore


func show_mouse(mouse: bool):
	if mouse:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
