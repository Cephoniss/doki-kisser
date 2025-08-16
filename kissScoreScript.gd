extends Label


@export var target_score: int = 3000
@export var combo_reset_time: = 3.0
@onready var game_timer = get_node("/root/GameSpace/GameTimer")
@onready var doki = get_node("/root/GameSpace/PixelDoki/PixelDokiArea2D")
var ComboPopup = preload("res://combo_score.tscn")
var score: int = 0
var base_score: int = 1
var combo: int = 0
var combo_timer: float = 0.0


signal score_updated(new_score)

func _ready():
	update_scoreboard()
	doki.connect("doki_clicked", Callable(self, "_on_doki_clicked"))

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		var mouse_pos = get_viewport().get_mouse_position()
		var space_state = get_world_2d().direct_space_state
		
		var query = PhysicsPointQueryParameters2D.new()
		query.position = mouse_pos
		query.collide_with_areas = true
		query.collide_with_bodies = true
		
		var results = space_state.intersect_point(query, 32) #hard number 32 allows upto 32 resualts in query
		
		for result in results:
			var node = result["collider"]
			if node.is_in_group("KissScoreGroup"):
				calculate_score(mouse_pos)
				break

func _on_doki_clicked(pos: Vector2):
	if score >= target_score:
		return
	
	calculate_score(pos)

func calculate_score(mouse_pos: Vector2):
	update_combo()
	var calculated_score = base_score * combo
	score += calculated_score
	print("target hit Score: ", score, " Combo: ", combo)
	emit_signal("score_updated", score)
	update_scoreboard()
	check_for_win_score()
	show_combo_popup(mouse_pos)

func show_combo_popup(pos: Vector2):
	if score >= target_score:
		return
	var popup = ComboPopup.instantiate()
	get_tree().current_scene.add_child(popup)
	popup.global_position = pos
	if combo_timer <= combo_reset_time:
		popup.setup(combo)
	else:
		popup.show_missed()
	
func update_scoreboard() -> void:
	text = "Kiss Score: %d Combo: %d  " % [score, combo]
	
func _process(delta: float) -> void:
	combo_timer += delta
	if combo_timer > combo_reset_time and combo != 0:
		combo =0
		var mouse_pos = get_viewport().get_mouse_position()
		show_combo_popup(mouse_pos)
		update_scoreboard()

func check_for_win_score():
	if score >= target_score:
		print("YOU WIN!")
		win_game()

func update_combo():
	if combo_timer <= combo_reset_time:
		combo += 1
	else:
		combo = 1
	combo_timer = 0.0
	
func combo_break():
	if combo <= 1:
		score -= 10
		print("Combo break!")
		update_scoreboard()

func win_game():
	get_tree().change_scene_to_file("res://end_scene.tscn")
