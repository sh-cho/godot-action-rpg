extends Node2D


onready var parent_node := get_parent()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		var grass_effect := preload("res://Effects/GrassEffect.tscn").instance()
		grass_effect.set_transform(get_transform())
		parent_node.add_child(grass_effect)
		queue_free()
