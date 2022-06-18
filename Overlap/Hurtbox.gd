extends Area2D

var invincible := false setget set_invincible

onready var timer := $Timer
onready var main := get_tree().current_scene
onready var collision_shape := $CollisionShape2D

onready var blink_anim_player := get_parent().get_node_or_null("BlinkAnimationPlayer")


func set_invincible(value: bool) -> void:
	invincible = value
	set_deferred("monitoring", !invincible)


func start_invincibility(duration: float):
	self.invincible = true
	collision_shape.set_deferred("disabeld", true)
	timer.start(duration)
	if blink_anim_player:
		blink_anim_player.play("Start")


func create_hit_effect() -> void:
	var effect = preload("res://Effects/HitEffect.tscn").instance()
	effect.global_position = global_position
	main.add_child(effect)


func _on_Timer_timeout() -> void:
	self.invincible = false
	collision_shape.disabled = false
	if blink_anim_player:
		blink_anim_player.play("Stop")
