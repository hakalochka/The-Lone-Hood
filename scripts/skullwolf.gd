extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var hit_collision: CollisionShape2D = $hitBox/hitCollision
@onready var attack_timer: Timer = $attackTimer

@onready var player = get_node("/root/level_init/Player")

#@export var patrol_distance: float = 100.0
@export var speed: float = 50.0
@export var chase_range := 150.0


@onready var direction = -1 
var start_position := global_position


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if direction <= 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true

	var distance_to_player = global_position.distance_to(player.global_position)

	if distance_to_player < chase_range:
		if player.global_position.x > global_position.x:
			direction = 1
		else:
			direction = -1

		velocity.x = direction * speed
		animated_sprite.play("run")
	else:
		velocity.x = 0
		animated_sprite.play("idle")
	
	move_and_slide()


func _on_hit_box_body_entered(body: Node2D) -> void:
	attack_timer.start()

func _on_attack_timer_timeout() -> void:
	hit_collision.disabled = true
	hit_collision.disabled = false
	attack_timer.start()


func _on_hit_box_body_exited(body: Node2D) -> void:
	attack_timer.stop()
