extends Control
@onready var music_slider: HSlider = $VBoxContainer/music/musicSlider
@onready var sfx_slider: HSlider = $VBoxContainer/sfx/sfxSlider

var custom_bindings := {
	"left": [KEY_A, KEY_LEFT],
	"right": [KEY_D, KEY_RIGHT],
	"jump": [KEY_W, KEY_LEFT],
	"pause": [KEY_ESCAPE, KEY_P]
}

var waiting_for_input = false
var current_action = ""
var current_index = 0

func _ready() -> void:
	var audio_settings = ConfigFileHandller.load_audio_settings()
	music_slider.value = min(audio_settings.music, 1.0)
	sfx_slider.value = min(audio_settings.sfx, 1.0)
	
	custom_bindings = ConfigFileHandller.load_keybindings()
	
	
	for row in $VBoxContainer.get_children():
		if row is HBoxContainer and row.get_child_count() >= 2:
			var buttons_box = row.get_child(1)
			if buttons_box is HBoxContainer:
				var action_name = row.name  # Make sure each row is named after the action!
				for i in range(2):  # 0 = primary, 1 = secondary
					var button = buttons_box.get_child(i)
					var keys = custom_bindings[action_name]
					if button is Button:
						button.pressed.connect(_on_key_button_pressed.bind(action_name, i))
						button.text = get_key_name(action_name, i)

func _on_music_slider_value_changed(value: float) -> void:
	var music_bus = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_mute(music_bus, value == 0)
	if value > 0:
		AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))

func _on_sfx_slider_value_changed(value: float) -> void:
	var sfx_bus = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_mute(sfx_bus, value == 0)
	if value > 0:
		AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(value))

func get_key_name(action_name: String, index: int) -> String:
	var events = InputMap.action_get_events(action_name)
	if index < events.size() and events[index] is InputEventKey:
		return OS.get_keycode_string(events[index].physical_keycode)
	return "Unbound"

func _on_key_button_pressed(action_name: String, index: int):
	waiting_for_input = true
	current_action = action_name
	current_index = index
	get_viewport().set_input_as_handled()

func _input(event):
	if waiting_for_input and event is InputEventKey and event.pressed:
		rebind_action(current_action, current_index, event.physical_keycode)
		waiting_for_input = false

func rebind_action(action_name: String, index: int, keycode: int):
	# Update the custom_bindings dictionary
	if not custom_bindings.has(action_name):
		custom_bindings[action_name] = []
	if custom_bindings[action_name].size() <= index:
		custom_bindings[action_name].resize(index + 1)
	custom_bindings[action_name][index] = keycode
	
	InputMap.action_erase_events(action_name)
	
	for key in custom_bindings[action_name]:
		if key != null:
			var new_event := InputEventKey.new()
			new_event.physical_keycode = key
			InputMap.action_add_event(action_name, new_event)
	# Update button label
	var row = $VBoxContainer.get_node(action_name)
	var buttons = row.get_child(1)
	var button = buttons.get_child(index)
	button.text = OS.get_keycode_string(keycode)
	button.release_focus()

	# Save updated bindings
	ConfigFileHandller.save_keybindings(custom_bindings)

func update_key_labels() -> void:
	for row in $VBoxContainer.get_children():
		if row is HBoxContainer and row.get_child_count() >= 2:
			var buttons_box = row.get_child(1)
			if buttons_box is HBoxContainer:
				var action_name = row.name
				for i in range(2):
					var button = buttons_box.get_child(i)
					if button is Button:
						button.text = get_key_name(action_name, i)

func _on_music_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigFileHandller.save_audio_settings("music", music_slider.value)


func _on_sfx_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigFileHandller.save_audio_settings("sfx", sfx_slider.value)
	


func _on_reset_pressed() -> void:
	ConfigFileHandller.reset_to_default_keybindings()
	custom_bindings = ConfigFileHandller.load_keybindings()
	update_key_labels()
	ConfigFileHandller.reset_to_default_audio()
	music_slider.value = 1.0
	sfx_slider.value = 1.0
	_on_music_slider_value_changed(1.0)
	_on_sfx_slider_value_changed(1.0)


func _on_back_btn_pressed() -> void:
	SoundManager.play()
	queue_free()
