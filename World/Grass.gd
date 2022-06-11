extends Node2D


onready var parent_node := get_parent()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		var grassEffect := preload("res://Effects/GrassEffect.tscn").instance()
		grassEffect.set_transform(get_transform())
		parent_node.add_child(grassEffect)
		queue_free()
