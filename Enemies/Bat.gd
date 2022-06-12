extends KinematicBody2D

var knockback := Vector2.ZERO

onready var stats = $Stats


func _physics_process(_delta: float) -> void:
	knockback = knockback.move_toward(Vector2.ZERO, 10)
	knockback = move_and_slide(knockback)


func _on_Hurtbox_area_entered(area: Area2D) -> void:
	stats.health -= 1
	knockback = area.knockback_vector * 200


func _on_Stats_no_health() -> void:
	queue_free()
