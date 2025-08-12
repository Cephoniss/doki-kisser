extends Node2D

@onready var combo_label: Label =$ComboLabel
var lifetime := 1.0
var move_up_speed := 30.0

func setup(combo_count: int):
	combo_label.text = "X%d COMBO!!" % combo_count
func show_missed():
	combo_label.text = "MISSED!!"
	print("missed")

func _process(delta: float) -> void:
	position.y -= move_up_speed * delta
	modulate.a -= delta
	
	lifetime -= delta
	if lifetime <= 0:
		queue_free()
