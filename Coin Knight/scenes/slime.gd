extends Node2D

var d = 1
const s = 60

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	if ray_cast_left.is_colliding():
		d = 1 
		animated_sprite.flip_h = false  # Turn right when hitting a block on the left
	if ray_cast_right.is_colliding():
		d = -1  # Turn left when hitting a block on the right
		animated_sprite.flip_h = true 
	position.x += d * s * delta
