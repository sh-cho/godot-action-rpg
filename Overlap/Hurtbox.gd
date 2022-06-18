extends Area2D

var invincible := false setget set_invincible

onready var timer := $Timer
onready var main := get_tree().current_scene


func set_invincible(value: bool) -> void:
	invincible = value
	set_deferred("monitoring", !invincible)


func start_invincibility(duration: float):
	self.invincible = true
	timer.start(duration)


func create_hit_effect() -> void:
	var effect = preload("res://Effects/HitEffect.tscn").instance()
	effect.global_position = global_position
	main.add_child(effect)


func _on_Timer_timeout() -> void:
	self.invincible = false
