extends Node2D

@onready var up_timer: Timer = $upTimer
@onready var down_timer: Timer = $downTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("RESET")
	down_timer.start()

func _on_down_timer_timeout() -> void:
	animation_player.play("up")
	up_timer.start()


func _on_up_timer_timeout() -> void:
	animation_player.play("down")
	down_timer.start()
