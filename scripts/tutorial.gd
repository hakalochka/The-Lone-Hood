extends Node2D

@onready var move: Label = $move
@onready var jump: Label = $jump

func _ready() -> void:
	var keybindings = ConfigFileHandller.load_keybindings()
	
	var right_keys = keybindings.get("right", [])
	var right_keycode = right_keys[0]
	var right_key = OS.get_keycode_string(right_keycode)
	
	var left_keys = keybindings.get("left", [])
	var left_keycode = left_keys[0]
	var left_key = OS.get_keycode_string(left_keycode)
	
	var jump_keys = keybindings.get("jump", [])
	var jump_keycode = jump_keys[0]
	var jump_key = OS.get_keycode_string(jump_keycode)
	
	move.text = "Use {0} and {1} to move".format([right_key, left_key])
	jump.text = "Use {0} to jump".format([jump_key])
