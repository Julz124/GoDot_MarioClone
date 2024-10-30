extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_dialogue: AcceptDialog = $deathDialogue

var hp = 10

func _on_dialogue_active(is_active: bool) -> void:
	print("script wurde ausgeführt")
	
#func _process(delta) -> void:
#	death_dialogue.dialogue_active.connect(_on_dialogue_active)

func _physics_process(delta: float) -> void:
		
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("jump_up")

	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	
	if velocity.y > 0:
		animated_sprite.play("fall_down")
			
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
