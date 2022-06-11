extends Node2D

onready var anim_sprite := $AnimatedSprite


func _ready() -> void:
	anim_sprite.frame = 0
	anim_sprite.play("Animate")


func _on_AnimatedSprite_animation_finished() -> void:
	queue_free()
