extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GameManager.health_check()
		if GameManager.can_restore_health():
			animation_player.play("pickup")
			GameManager.can_restore = false
		
