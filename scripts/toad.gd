extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var attack_timer: Timer = $attackTimer
@onready var hit_box: Area2D = $hitBox

@onready var player = get_node("/root/level_init/Player")

@export var speed: float = 30.0
@export var chase_range := 250.0
@export var attack_range := 28.0

@onready var direction = -1 
@onready var isAttacking := false
func _physics_process(delta: float) -> void:
	if isAttacking:
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if direction <= 0:
		animated_sprite.flip_h = true
		hit_box.scale.x = -1
	else:
		animated_sprite.flip_h = false
		hit_box.scale.x = 1

	var distance_to_player = global_position.distance_to(player.global_position)

	# Check if within chase range
	if distance_to_player < chase_range:
		if distance_to_player < attack_range:  # If within attack range, trigger attack
			if not isAttacking:
				isAttacking = true
				animated_sprite.stop()  # Stop any current animations
				animation_player.play("attack")  # Play the attack animation
				attack_timer.start()  # Start the attack timer to track the animation duration
		else:  # Otherwise, chase the player
			isAttacking = false
			if player.global_position.x > global_position.x:
				direction = 1
			else:
				direction = -1

			velocity.x = direction * speed
			animated_sprite.play("walk")
	else:
		velocity.x = 0
		animated_sprite.play("idle")
	
	move_and_slide()


func _on_attack_timer_timeout() -> void:
	isAttacking = false
	
	
