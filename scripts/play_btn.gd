extends TextureButton

@onready var play_txt: Control = $play_txt
@onready var play_txt_pressed: Control = $play_txt_pressed



func _on_button_down() -> void:
	play_txt.visible = false
	play_txt_pressed. visible = true


func _on_button_up() -> void:
	play_txt.visible = true
	play_txt_pressed. visible = false


func _on_pressed() -> void:
	SoundManager.play()
	get_tree().change_scene_to_file("res://scenes/levels.tscn")
