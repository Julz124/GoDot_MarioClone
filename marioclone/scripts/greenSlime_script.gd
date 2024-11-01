extends Node2D

const SPEED = 60
var direction = 1

signal decrease_hp

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_cliff_right: RayCast2D = $RayCastCliffRight
@onready var ray_cast_cliff_left: RayCast2D = $RayCastCliffLeft

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var hitzone: Area2D = $hitzone

func _process(delta: float) -> void:
	if ray_cast_right.is_colliding() || !ray_cast_cliff_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding() || !ray_cast_cliff_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	
	position.x += direction * SPEED * delta

func _on_hitzone_hit() -> void:
	decrease_hp.emit()
