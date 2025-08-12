extends Area2D


@onready var audio_player = $AudioStreamPlayer2D
@onready var kiss_effect = $KissEffect
@export var kiss_targets: Array[PackedScene] = []
@export var move_speed: float = 150.0
@export var rotation_speed: float = 90.0
var velocity := Vector2.ZERO
var clicked := false

func _ready():
	add_to_group("KissScoreGroup")
	connect("input_event", Callable(self, "_on_input_event"))
	
	velocity = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized() * move_speed
	
	despawn()
	
func  _process(delta):
	position += velocity * delta
	rotation_degrees += rotation_speed * delta

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and not clicked:
		clicked = true
		audio_player.play()
		show_kiss_effect()
		spawn_child()
		remove_from_group("KissScoreGroup")
		await get_tree().create_timer(0.3).timeout
		queue_free()

func show_kiss_effect():
	kiss_effect.show()
	kiss_effect.modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property(kiss_effect, "modulate:a", 0.0, 0.3)

func spawn_child():
	if kiss_targets.is_empty():
		return
	for i in 2:
		var random_index = randi() % kiss_targets.size()
		var target_scene = kiss_targets[random_index]
		var new_target = target_scene.instantiate()
		new_target.position = position + Vector2(randf_range(-20, 20), randf_range(-20, 20))
		get_parent().add_child(new_target)
		
func despawn():
	await get_tree().create_timer(3.5).timeout
	queue_free()
