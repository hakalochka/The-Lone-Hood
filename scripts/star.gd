extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GameManager.stars_update()
		animation_player.play("pickup")
