extends Control

var hearts := 4 setget set_hearts
var max_hearts := 4 setget set_max_hearts

onready var heart_ui_full := $HeartUIFull
onready var heart_ui_empty := $HeartUIEmpty


func _ready() -> void:
	self.hearts = PlayerStats.health
	self.max_hearts = PlayerStats.max_health
	PlayerStats.connect("health_changed", self, "set_hearts")
	PlayerStats.connect("max_health_changed", self, "set_max_hearts")


func set_hearts(value: int):
	hearts = value
	heart_ui_full.rect_size.x = hearts * 15


func set_max_hearts(value: int):
	max_hearts = value
	heart_ui_empty.rect_size.x = max_hearts * 15
	heart_ui_full.rect_size.x = hearts * 15
