extends Panel

@onready var heart: Sprite2D = $heart

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update(whole: bool):
	if whole:
		heart.visible = true
	else:
		heart.visible = false
	
