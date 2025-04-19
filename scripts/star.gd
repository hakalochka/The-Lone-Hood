extends Area2D

@onready var game_manager: Node = %gameManager

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		game_manager.stars_update()
		queue_free()
