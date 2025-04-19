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
