extends TextureButton

@onready var credits_txt_pressed: Node2D = $credits_txt_pressed
@onready var credits_txt: Node2D = $credits_txt



func _on_button_down() -> void:
	credits_txt.visible = false
	credits_txt_pressed.visible = true


func _on_button_up() -> void:
	credits_txt.visible = true
	credits_txt_pressed.visible = false
