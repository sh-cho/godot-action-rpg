extends KinematicBody2D

var knockback := Vector2.ZERO

onready var stats = $Stats
onready var parent_node := get_parent()


func _physics_process(_delta: float) -> void:
	knockback = knockback.move_toward(Vector2.ZERO, 10)
	knockback = move_and_slide(knockback)


func _on_Hurtbox_area_entered(area: Hitbox) -> void:
	stats.health -= area.damage
	knockback = area.knockback_vector * 200


func _on_Stats_no_health() -> void:
	var enemy_death_effect = preload("res://Effects/EnemyDeathEffect.tscn").instance()
	enemy_death_effect.set_transform(get_transform())
	parent_node.add_child(enemy_death_effect)
	queue_free()
