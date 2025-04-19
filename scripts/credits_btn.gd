extends TextureButton

@onready var credits_txt_pressed: Control = $credits_txt_pressed
@onready var credits_txt: Control = $credits_txt



func _on_button_down() -> void:
	credits_txt.visible = false
	credits_txt_pressed.visible = true


func _on_button_up() -> void:
	credits_txt.visible = true
	credits_txt_pressed.visible = false


func _on_pressed() -> void:
	SoundManager.play()
	get_tree().change_scene_to_file("res://scenes/credits_menu.tscn")
