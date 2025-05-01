extends Node2D

@onready var health_container: HBoxContainer = $CanvasLayer/healthContainer
@onready var player: CharacterBody2D = $Player
@onready var timer: Timer = $Timer
@onready var time: Label = $CanvasLayer/time
@onready var finish: Area2D = $finish
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var respawn_position: Marker2D = $respawnPosition
@onready var killzone: Area2D = $killzone
@onready var checkpoint: Area2D = $checkpoint



@onready var start_position = respawn_position.global_position

var total_time_sec: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.show_mouse(false)
	health_container.set_max_hearts(player.maxHealth)
	health_container.update_hearts(player.currentHealth)
	player.healthChanged.connect(health_container.update_hearts)
	player.lost.connect(open_lost_menu)
	
	killzone.fall.connect(respawn)
	GameManager.healthCheck.connect(health_restore)
	finish.levelCompleted.connect(level_completed)
	
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pause()

func open_lost_menu():
	timer.stop()
	get_tree().paused = true
	var lost_menu = preload("res://scenes/lost_menu.tscn").instantiate()
	canvas_layer.add_child(lost_menu)
	GameManager.show_mouse(true)


func _on_timer_timeout() -> void:
	total_time_sec += 1
	var m = int(total_time_sec / 60)
	var s = total_time_sec - m * 60
	time.text = "Time: " + "%02d:%02d" % [m, s]

func pause():
	if Input.is_action_pressed("pause"):
		get_tree().paused = true
		var pause_menu = preload("res://scenes/pause_menu.tscn").instantiate()
		canvas_layer.add_child(pause_menu)
		GameManager.show_mouse(true)

func level_completed():
	time.visible = false
	health_container.visible = false
	get_tree().paused = true
	var level_completed_menu = preload("res://scenes/level_completed_menu.tscn").instantiate()
	level_completed_menu.total_time_sec = total_time_sec
	level_completed_menu.stars = GameManager.stars
	canvas_layer.add_child(level_completed_menu)
	GameManager.show_mouse(true)



func health_restore():
	if player.currentHealth < player.maxHealth:
		GameManager.can_restore = true
		player.currentHealth += 1
		player.healthChanged.emit(player.currentHealth)
		
func respawn():
	player.currentHealth -=1
	player.healthChanged.emit(player.currentHealth)
	if player.currentHealth <= 0: open_lost_menu()
	else: player.global_position = start_position


func _on_checkpoint_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("checkpoint")
		respawn_position.global_position = checkpoint.global_position
		start_position = respawn_position.global_position
