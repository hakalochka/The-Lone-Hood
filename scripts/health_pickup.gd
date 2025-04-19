extends Area2D

@onready var game_manager: Node = %gameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		game_manager.health_check()
		if game_manager.can_restore_health():
			animation_player.play("pickup")
			game_manager.can_restore = false
		
