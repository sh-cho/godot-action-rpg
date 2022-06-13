extends Area2D

signal invincibility_started
signal invincibility_ended

var invincible := false setget set_invincible

onready var timer := $Timer
onready var main := get_tree().current_scene


func set_invincible(value: bool) -> void:
	invincible = value
	emit_signal("invincibility_started" if invincible else "invincibility_ended")


func start_invincibility(duration: float):
	self.invincible = true
	timer.start(duration)


func create_hit_effect() -> void:
	var effect = preload("res://Effects/HitEffect.tscn").instance()
	effect.global_position = global_position
	main.add_child(effect)


func _on_Timer_timeout() -> void:
	self.invincible = false


func _on_Hurtbox_invincibility_started() -> void:
	set_deferred("monitoring", false)  # should be set via `set_deferred`


func _on_Hurtbox_invincibility_ended() -> void:
	monitoring = true
