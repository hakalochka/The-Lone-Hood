extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft

@export var patrol_distance: float = 100.0
@export var speed: float = 50.0
@export var maxHealth: int = 1
@onready var currentHealth: int = maxHealth

@onready var direction = -1 
@onready var start_position = global_position

@onready var isDead := false

var velocity = Vector2.ZERO
var gravity = 500


func _physics_process(delta: float) -> void:
	if isDead:
		return
	
	if direction <= 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
	
	
	
	position.x += direction * speed * delta
	var distance_from_start = global_position.x - start_position.x
	
	if ray_cast_right.is_colliding():
		var collider = ray_cast_right.get_collider()
		if collider and not collider.is_in_group("Player"):
			direction = -1
		
	if ray_cast_left.is_colliding():
		var collider = ray_cast_right.get_collider()
		if collider and not collider.is_in_group("Player"):
			direction = 1
		
		
	if abs(distance_from_start) >= patrol_distance:
		direction *= -1  
	
func take_damage(damage: int):
	currentHealth -= damage
	animated_sprite.flip_v = true
	if currentHealth <= 0:
		isDead = true
		speed = 200
		velocity.y += gravity
		position += velocity
