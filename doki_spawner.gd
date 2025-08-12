extends Node2D

@export var kiss_targets: Array[PackedScene] = []
@export var spawn_interval := 0.5
var time_accumulator := 0.0

func spawn_random_kiss_target():
	if kiss_targets.is_empty():
		return
	
	var random_index = randi() % kiss_targets.size()
	var target_scene = kiss_targets[random_index]
	var target_instance = target_scene.instantiate()
	
	var screen_size = get_viewport_rect().size
	target_instance.position = Vector2(
		randf_range(50, screen_size.x - 50),
		randf_range(50, screen_size.y -50)
	)
	add_child(target_instance)
	
