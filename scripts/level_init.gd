extends Node2D

@onready var health_container: HBoxContainer = $CanvasLayer/healthContainer
@onready var player: CharacterBody2D = $Player
@onready var timer: Timer = $Timer
@onready var time: Label = $CanvasLayer/time
@onready var finish: Area2D = $finish
@onready var game_manager: Node = %gameManager

var total_time_sec: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	health_container.set_max_hearts(player.maxHealth)
	health_container.update_hearts(player.currentHealth)
	player.healthChanged.connect(health_container.update_hearts)
	player.lost.connect(open_lost_menu)
	
	
	game_manager.healthCheck.connect(health_restore)
	finish.levelCompleted.connect(level_completed)
	
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pause()

func open_lost_menu():
	timer.stop()
	get_tree().paused = true
	var lost_menu = preload("res://scenes/lost_menu.tscn").instantiate()
	$CanvasLayer.add_child(lost_menu)


func _on_timer_timeout() -> void:
	total_time_sec += 1
	var m = int(total_time_sec / 60)
	var s = total_time_sec - m * 60
	time.text = "Time: " + "%02d:%02d" % [m, s]

func pause():
	if Input.is_action_pressed("pause"):
		get_tree().paused = true
		var pause_menu = preload("res://scenes/pause_menu.tscn").instantiate()
		$CanvasLayer.add_child(pause_menu)

func level_completed():
	$CanvasLayer.visible = false
	get_tree().paused = true
	print("finish")


func health_restore():
	if player.currentHealth < player.maxHealth:
		game_manager.can_restore = true
		player.currentHealth += 1
		player.healthChanged.emit(player.currentHealth)
		
