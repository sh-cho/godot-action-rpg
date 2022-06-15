extends Area2D

var overlapping_areas = Array()

func check_overlap():
	overlapping_areas = get_overlapping_areas()
	return overlapping_areas != null

func get_push_vector():
	if overlapping_areas:
		return overlapping_areas[0].global_position.direction_to(global_position)
	else:
		return Vector2.ZERO
