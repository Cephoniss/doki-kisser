extends Area2D

@export var move_speed: float = 100.0
@export var rotation_speed: float = 90.0
var velocity := Vector2.ZERO

func _ready():
	add_to_group("KissScoreGroup")
	connect("input_event", Callable(self, "_on_input_event"))
	
	velocity = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized() * move_speed
	
	despawn()
	
func  _process(delta):
	position += velocity * delta
	rotation_degrees += rotation_speed * delta

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		#var spawner = get_node_or_null("/root/game_space")
		#if spawner and spawner.has_method("spawn_random_kiss_target"):
			#spawner.spawn_random_kiss_target()
			#spawner.spawn_random_kiss_target()
		queue_free()
func despawn():
	await get_tree().create_timer(2.0).timeout
	queue_free()
