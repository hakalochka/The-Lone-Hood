extends Area2D

@export var speed: float = 300.0
var direction := Vector2.RIGHT  # Will be set when spawned
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.start()

func _physics_process(delta):
	if direction == Vector2.RIGHT: scale.x = 1
	elif direction == Vector2.LEFT: scale.x = -1
	position += direction * speed * delta
	


func _on_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.take_damage(1)
	elif not body.is_in_group("Player"):
		queue_free()
