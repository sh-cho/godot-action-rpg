extends Area2D

export(bool) var show_hit = true

onready var main := get_tree().current_scene


func _on_Hurtbox_area_entered(_area: Area2D) -> void:
	if show_hit:
		var effect = preload("res://Effects/HitEffect.tscn").instance()
		effect.global_position = global_position
		main.add_child(effect)
