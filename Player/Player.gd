extends KinematicBody2D

const ACCELERATION := 100
const MAX_SPEED := 80
const FRICTION := 10


onready var anim_player := $AnimationPlayer

var velocity := Vector2.ZERO


func _physics_process(delta: float) -> void:
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		anim_player.play("RunRight" if input_vector.x > 0 else "RunLeft")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION)
	else:
		anim_player.play("IdleRight")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)

	velocity = move_and_slide(velocity)
