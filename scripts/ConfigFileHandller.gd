extends Node

const CONFIG_PATH := "user://settings.ini"
const SECTION_KEYBINDINGS := "Keybindings"
const SECTION_AUDIO := "Audio"

var config := ConfigFile.new()

const default_bindings := {
	"left": [KEY_A, KEY_LEFT],
	"right": [KEY_D, KEY_RIGHT],
	"jump": [KEY_W, KEY_UP],
	"pause": [KEY_ESCAPE, KEY_P]
}

const default_audio := {"music": 0.5, "sfx": 0.5}

func _ready() -> void:
	if config.load(CONFIG_PATH) != OK:
		reset_to_default_keybindings()
	
	if not config.has_section(SECTION_AUDIO):
		save_audio_settings("music", 0.5)
		save_audio_settings("sfx", 0.5)
	load_saved_settings()
	
func save_keybindings(bindings: Dictionary) -> void:

	for action_name in bindings.keys():
		var events = InputMap.action_get_events(action_name)
		var keys := []
		for event in events:
			if event is InputEventKey:
				keys.append(event.physical_keycode)
		config.set_value(SECTION_KEYBINDINGS, action_name, keys)
	config.save(CONFIG_PATH)
	
func load_keybindings() -> Dictionary:
	var loaded_bindings := {}
	for action_name in config.get_section_keys(SECTION_KEYBINDINGS):
		if not InputMap.has_action(action_name):
			continue

		# Clear existing bindings
		for event in InputMap.action_get_events(action_name):
			if event is InputEventKey:
				InputMap.action_erase_event(action_name, event)

		var keycodes = config.get_value(SECTION_KEYBINDINGS, action_name)
		loaded_bindings[action_name] = keycodes

		for code in keycodes:
			var event := InputEventKey.new()
			event.physical_keycode = code
			InputMap.action_add_event(action_name, event)

	return loaded_bindings


func reset_to_default_keybindings() -> void:
	for action_name in default_bindings.keys():
		# Clear existing bindings
		for event in InputMap.action_get_events(action_name):
			if event is InputEventKey:
				InputMap.action_erase_event(action_name, event)

		# Add default bindings
		for keycode in default_bindings[action_name]:
			var event := InputEventKey.new()
			event.physical_keycode = keycode
			InputMap.action_add_event(action_name, event)

	save_keybindings(default_bindings)
	
func save_audio_settings(key: String, value: float) -> void:
	config.set_value(SECTION_AUDIO, key, value)
	config.save(CONFIG_PATH)

func load_audio_settings():
	if config.load(CONFIG_PATH) != OK:
		return default_audio
	var audio_settings = {}
	for key in config.get_section_keys(SECTION_AUDIO):
		audio_settings[key] = config.get_value(SECTION_AUDIO, key)

	return audio_settings

func reset_to_default_audio():
	config.set_value("Audio", "music", 0.5)
	config.set_value("Audio", "sfx", 0.5)
	config.save(CONFIG_PATH)
	
func load_saved_settings():
	for action_name in config.get_section_keys(SECTION_KEYBINDINGS):
		if not InputMap.has_action(action_name):
			continue

		# Clear existing bindings
		for event in InputMap.action_get_events(action_name):
			if event is InputEventKey:
				InputMap.action_erase_event(action_name, event)

		var keycodes = config.get_value(SECTION_KEYBINDINGS, action_name)
		for code in keycodes:
			var event := InputEventKey.new()
			event.physical_keycode = code
			InputMap.action_add_event(action_name, event)
	
	var audio_settings = {}
	for key in config.get_section_keys(SECTION_AUDIO):
		audio_settings[key] = config.get_value(SECTION_AUDIO, key)

	# Apply the audio settings to the game
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(audio_settings.get("music", 1.0)))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(audio_settings.get("sfx", 1.0)))
