extends Node2D

onready var parent_node := get_parent()


func create_grass_effect():
	var grass_effect := preload("res://Effects/GrassEffect.tscn").instance()
	grass_effect.set_transform(get_transform())
	parent_node.add_child(grass_effect)


func _on_Hurtbox_area_entered(area: Area2D) -> void:
	create_grass_effect()
	queue_free()
