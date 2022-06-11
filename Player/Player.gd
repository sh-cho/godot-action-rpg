extends KinematicBody2D

const ACCELERATION := 100
const MAX_SPEED := 80
const ROLL_SPEED := MAX_SPEED * 1.3
const FRICTION := 10


onready var anim_player := $AnimationPlayer
onready var anim_tree := $AnimationTree
onready var anim_state: AnimationNodeStateMachinePlayback = anim_tree.get("parameters/playback")


enum State { MOVE, ROLL, ATTACK }


var state = State.MOVE
var velocity := Vector2.ZERO
var roll_vector := Vector2.LEFT


func _ready():
	anim_tree.active = true


func _physics_process(delta: float) -> void:
	match state:
		State.MOVE:
			move_state(delta)

		State.ROLL:
			roll_state(delta)

		State.ATTACK:
			attack_state(delta)


func move_state(delta: float) -> void:
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		anim_tree.set("parameters/Idle/blend_position", input_vector)
		anim_tree.set("parameters/Run/blend_position", input_vector)
		anim_tree.set("parameters/Attack/blend_position", input_vector)
		anim_tree.set("parameters/Roll/blend_position", input_vector)
		anim_state.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION)
	else:
		anim_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)

	move()

	if Input.is_action_just_pressed("roll"):
		state = State.ROLL
	if Input.is_action_just_pressed("attack"):
		state = State.ATTACK

func roll_state(delta: float) -> void:
	velocity = roll_vector * ROLL_SPEED
	anim_state.travel("Roll")
	move()

func attack_state(delta: float) -> void:
	velocity = Vector2.ZERO
	anim_state.travel("Attack")

func move():
	velocity = move_and_slide(velocity)

func roll_animation_finished():
	velocity *= 0.8
	state = State.MOVE

func attack_animation_finished():
	state = State.MOVE
