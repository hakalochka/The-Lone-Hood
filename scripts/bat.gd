extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft

@export var patrol_distance: float = 100.0
@export var speed: float = 50.0

@onready var direction = -1 
@onready var start_position = global_position

func _physics_process(delta: float) -> void:
	if direction <= 0:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false
	
	position.x += direction * speed * delta
	var distance_from_start = global_position.x - start_position.x
	
	if ray_cast_right.is_colliding():
		direction = -1
		
	if ray_cast_left.is_colliding():
		direction = 1
		
		
	if abs(distance_from_start) >= patrol_distance:
		direction *= -1  
	
