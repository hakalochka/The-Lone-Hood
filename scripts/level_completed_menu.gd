extends Control

@onready var time: Label = $time
@onready var star_container: HBoxContainer = $star_container
@onready var canvas_layer: CanvasLayer = get_node("/root/level_init/CanvasLayer")

var total_time_sec: int = 0
var stars: int = 0

func _ready() -> void:
	var m = int(total_time_sec / 60)
	var s = total_time_sec - m * 60
	time.text = "Time: " + "%02d:%02d" % [m, s]
	star_container.update_stars(stars)
	
	
	var next_level = get_next_level()
	
	GameManager.avalible_levels["lvl_" + str(next_level)] = true
	GameManager.save_file()


func _on_next_btn_pressed() -> void:
	GameManager.stars = 0
	get_tree().paused = false
	SoundManager.play()
	
	var next_level = get_next_level()
	var next_level_path = "res://scenes/lvl_%d.tscn" % next_level
	
	if ResourceLoader.exists(next_level_path):
		get_tree().change_scene_to_file(next_level_path)
	else:
		get_tree().change_scene_to_file("res://scenes/levels.tscn")

		

func get_next_level():
	var current_scene_path = get_tree().current_scene.scene_file_path
	
	# Extract the level number from the filename 
	var lvlname = current_scene_path.get_file().get_basename()  #lvl_1
	var current_level = lvlname.substr(4, lvlname.length() - 4).to_int() #1
	var next_level = current_level + 1
	return next_level

func _on_options_btn_pressed() -> void:
	SoundManager.play()
	var options_menu = preload("res://scenes/options_menu.tscn").instantiate()
	canvas_layer.add_child(options_menu)
