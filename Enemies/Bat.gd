extends KinematicBody2D

enum { IDLE, WANDER, CHASE }

var velocity := Vector2.ZERO
var knockback := Vector2.ZERO
var state = CHASE

export var ACCELERATION := 100
export var MAX_SPEED := 30
export var FRICTION := 10

onready var stats = $Stats
onready var parent_node := get_parent()
onready var player_detection_zone := $PlayerDetectionZone
onready var anim_sprite := $AnimatedSprite


func _physics_process(_delta: float) -> void:
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
			seek_player()
		
		WANDER:
			pass
		
		CHASE:
			var player = player_detection_zone.player
			if player != null:
				var direction = global_position.direction_to(player.global_position)
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION)
			else:
				state = IDLE
			anim_sprite.flip_h = velocity.x < 0

	velocity = move_and_slide(velocity)


func seek_player():
	if player_detection_zone.can_see_player():
		state = CHASE


func _on_Hurtbox_area_entered(area: Hitbox) -> void:
	stats.health -= area.damage
	knockback = area.knockback_vector * 200


func _on_Stats_no_health() -> void:
	var enemy_death_effect = preload("res://Effects/EnemyDeathEffect.tscn").instance()
	enemy_death_effect.set_transform(get_transform())
	parent_node.add_child(enemy_death_effect)
	queue_free()
