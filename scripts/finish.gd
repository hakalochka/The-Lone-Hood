extends Area2D

signal levelCompleted

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		levelCompleted.emit()
		
