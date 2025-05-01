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



func _on_next_btn_pressed() -> void:
	GameManager.stars = 0
	get_tree().paused = false
	SoundManager.play()
	var current_scene_path = get_tree().current_scene.scene_file_path
	
	# Extract the level number from the filename (e.g., "Level1.tscn")
	var filename = current_scene_path.get_file().get_basename()  # e.g., "Level1"
	var current_level = filename.substr(4, filename.length() - 4).to_int()
	print(current_level)
	var next_level = current_level + 1
	
	var next_level_path = "res://scenes/lvl_%d.tscn" % next_level
	
	if ResourceLoader.exists(next_level_path):
		get_tree().change_scene_to_file(next_level_path)
	else:
		print("Next level does not exist!")
		


func _on_options_btn_pressed() -> void:
	SoundManager.play()
	var options_menu = preload("res://scenes/options_menu.tscn").instantiate()
	canvas_layer.add_child(options_menu)
