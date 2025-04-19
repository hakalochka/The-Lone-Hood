extends Area2D

@onready var game_manager: Node = %gameManager


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		game_manager.health_check()
		if game_manager.can_restore_health():
			queue_free()
			game_manager.can_restore = false
		
