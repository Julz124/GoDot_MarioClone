extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_timer: Timer = $Timer

var jump = true

var bounce = false

var hp = 10
var hit = false

signal dead
signal curr_hp

func _init():
	print(hp)
	curr_hp.emit(hp)

func _on_green_slime_decrease_hp() -> void:
	hit = true
	hp -= 1
	curr_hp.emit(hp)

func _physics_process(delta: float) -> void:
		
	if not is_on_floor():
		jump_timer.start(0.5)
		velocity += get_gravity() * delta
		
	if is_on_floor():
		jump = true

	if Input.is_action_just_pressed("jump") and jump:
		jump = false
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("jump_up")

	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	if is_on_floor() && (animated_sprite.animation != "hit"):
		bounce = false
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	
	if hit == true:
		bounce = true
		velocity.y = -150
		if animated_sprite.flip_h == true:
			direction = 1
		else:
			direction = -1
		animated_sprite.play("hit")
		hit = false
	
	if hp == 0:
		animated_sprite.play("death")
		dead.emit()
	
	if velocity.y > 0 && (animated_sprite.animation != "hit"):
		animated_sprite.play("fall_down")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_timer_timeout() -> void:
	jump = false
