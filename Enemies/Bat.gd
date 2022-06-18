extends KinematicBody2D

enum { IDLE, WANDER, CHASE }

export var ACCELERATION := 100
export var MAX_SPEED := 30
export var FRICTION := 10

var velocity := Vector2.ZERO
var knockback := Vector2.ZERO
var state = CHASE
var player = null

onready var stats = $Stats
onready var parent_node := get_parent()
onready var player_detection_zone := $PlayerDetectionZone
onready var anim_sprite := $AnimatedSprite
onready var hurtbox = $Hurtbox
onready var soft_collision = $SoftCollision
onready var wander_controller = $WanderController


func _ready() -> void:
	state = pick_random_state([IDLE, WANDER])
	anim_sprite.play("Animate")


func _physics_process(delta: float) -> void:
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION)
	knockback = move_and_slide(knockback)

	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION / 10)
			if wander_controller.timer.is_stopped():
				update_wander()

		WANDER:
			if wander_controller.timer.is_stopped():
				update_wander()

			accelerate_towards_point(wander_controller.target_position)

			# XXX: ?
			if global_position.distance_to(wander_controller.target_position) <= MAX_SPEED:
				update_wander()

		CHASE:
			if player != null:
				accelerate_towards_point(player.global_position)
			else:
				state = IDLE

	if soft_collision.check_overlap():
		velocity += soft_collision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)


func update_wander() -> void:
	state = pick_random_state([IDLE, WANDER])
	wander_controller.start_wander_timer(rand_range(1, 3))


func accelerate_towards_point(point: Vector2) -> void:
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION)
	anim_sprite.flip_h = velocity.x < 0


func pick_random_state(state_list: Array):
	return state_list[randi() % state_list.size()]


func _on_Hurtbox_area_entered(area: Hitbox) -> void:
	stats.health -= area.damage
	knockback = area.knockback_vector * 200
	hurtbox.create_hit_effect()


func _on_Stats_no_health() -> void:
	var enemy_death_effect = preload("res://Effects/EnemyDeathEffect.tscn").instance()
	enemy_death_effect.set_transform(get_transform())
	parent_node.add_child(enemy_death_effect)
	queue_free()


func _on_PlayerDetectionZone_body_entered(body: Node) -> void:
	player = body
	state = CHASE


func _on_PlayerDetectionZone_body_exited(_body: Node) -> void:
	state = IDLE
