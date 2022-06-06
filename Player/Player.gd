extends KinematicBody2D

const ACCELERATION := 100
const MAX_SPEED := 80
const FRICTION := 10


onready var anim_player := $AnimationPlayer
onready var anim_tree := $AnimationTree
onready var anim_state: AnimationNodeStateMachinePlayback = anim_tree.get("parameters/playback")


func _physics_process(delta: float) -> void:
	var velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if velocity != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", velocity)
		anim_tree.set("parameters/Run/blend_position", velocity)
		anim_state.travel("Run")
		velocity = velocity.move_toward(velocity * MAX_SPEED, ACCELERATION)
	else:
		anim_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)

	move_and_slide(velocity)
