extends Node

signal no_health
signal health_changed(value)
signal max_health_changed(value)

export(int) var max_health := 2 setget set_max_health

var health := max_health setget set_health


func _ready() -> void:
	self.health = max_health


func set_max_health(value: int) -> void:
	max_health = max(value, 1)
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)


func set_health(value: int) -> void:
	health = clamp(value, 0, max_health)
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")
