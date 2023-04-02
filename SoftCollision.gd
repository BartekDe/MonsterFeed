extends Area2D

var overlapping_areas = Array()

func _physics_process(delta):
	self.overlapping_areas = get_overlapping_areas()
	
func get_push_vector():
	if is_colliding():
		var area = self.overlapping_areas[0]
		return area.global_position.direction_to(self.global_position)
	else:
		return Vector2.ZERO
		
func is_colliding():
	return self.overlapping_areas.size() > 0
