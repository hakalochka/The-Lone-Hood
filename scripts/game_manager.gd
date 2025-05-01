extends Node

signal healthCheck

var stars: int = 0
var can_restore: bool = false

var levels_file = "user://save.dat"
var avalible_levels = {
	"lvl_1" : true,
	"lvl_2" : false,
	"lvl_3" : false,
	"lvl_4" : false,
	"lvl_5" : false,
	"lvl_6" : false,
	"lvl_7" : false,
	"lvl_8" : false,
	"lvl_9" : false,
	"lvl_10" : false
}

func _ready() -> void:
	load_file()

func stars_update():
	stars += 1

func health_check():
	healthCheck.emit()

func can_restore_health() -> bool:
	return can_restore


func show_mouse(mouse: bool):
	if mouse:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func save_file():
	var file = FileAccess.open(levels_file, FileAccess.WRITE)
	var levels_data = create_levels_data()
	file.store_var(levels_data)

func load_file():
	var file = FileAccess.open(levels_file, FileAccess.READ)
	if FileAccess.file_exists(levels_file):
		var loaded_levels_data = file.get_var()
		avalible_levels = loaded_levels_data


func create_levels_data():
	var levels_dict = avalible_levels
	return levels_dict
