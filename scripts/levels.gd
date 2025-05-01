extends Control

@onready var grid_container: GridContainer = $CanvasLayer/GridContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button in grid_container.get_children():
		if button is TextureButton:
			button.pressed.connect(_on_lvl_btn_pressed.bind(button))
			var lvl = button.name
			var is_avalible = GameManager.avalible_levels.get(lvl, false)
			if not is_avalible:
				button.disabled = true
	
		

func _on_lvl_btn_pressed(button):
	SoundManager.play()
	var path = "res://scenes/" + button.name + ".tscn"
	get_tree().change_scene_to_file(path)


	
