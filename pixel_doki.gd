extends Area2D


@export var kiss_targets: Array[PackedScene] = []
@export var cooldown_time: float = 4.0
@onready var kiss_effect = $KissEffect
@onready var blush_effect = $BlushSprite
var on_cooldown := false

signal doki_clicked(pos: Vector2)

func _ready():
	connect("input_event", Callable(self,"_on_input_event"))
	
	var cooldown_timer = $"../CooldownTimer"
	cooldown_timer.wait_time = cooldown_time
	cooldown_timer.connect("timeout", Callable(self, "_on_cooldown_timer_timeout"))

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and not on_cooldown:
		emit_signal("doki_clicked", global_position)
		on_cooldown = true
		$"../CooldownTimer".start()
		show_kiss_effect()
		for i in range(randi_range(2,4)):
			spawn_random_targets()

func _on_cooldown_timer_timeout():
	on_cooldown = false
	blush_effect.hide()

func show_kiss_effect():
	kiss_effect.show()
	kiss_effect.modulate.a = 1.0
	blush_effect.show()
	var tween = create_tween()
	tween.tween_property(kiss_effect, "modulate:a", 0.0, 1.0)

func spawn_random_targets():
	if kiss_targets.is_empty():
		return
	
	var target_scene = kiss_targets[randi() % kiss_targets.size()]
	var target_instance = target_scene.instantiate()
	var screen_size = get_viewport_rect().size
	target_instance.position = Vector2(
		randf_range(50, screen_size.x - 50),
		randf_range(50, screen_size.y - 50)
	)
	get_tree().current_scene.add_child(target_instance)
