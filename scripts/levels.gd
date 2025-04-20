extends Control

@onready var grid_container: GridContainer = $CanvasLayer/GridContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button in grid_container.get_children():
		if button is TextureButton:
			button.pressed.connect(_on_lvl_btn_pressed.bind(button))

func _on_lvl_btn_pressed(button):
	SoundManager.play()
	var path = "res://scenes/" + button.name + ".tscn"
	get_tree().change_scene_to_file(path)


	
