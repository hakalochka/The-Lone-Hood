extends HBoxContainer

@onready var heartClass = preload("res://scenes/heart.tscn")

func set_max_hearts(max_hearts: int):
	for i in range(max_hearts):
		var heart = heartClass.instantiate()
		add_child(heart)
	
func update_hearts(currentHealth: int):
	var heart = get_children()
	
	for i in range(currentHealth):
		heart[i].update(true)
	
	for i in range(currentHealth, heart.size()):
		heart[i].update(false)
