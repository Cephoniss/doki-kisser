extends RichTextLabel

var lines = [
	"Come in Mint. This is Crowki.",
	"For this mission you will need to click on Doki to give her a smooch! Note that there will be a short delay before you can click her again.",
	"Tomatos and Dragoons will spawn randomly. Click on them to increase your score and combo multiplier",
	"The combo multiplier will break if you do not click on a target after 3 seconds.",
	"Make sure to fill up the bar to win the game!"
]

var current_line := 0
var is_typing := false
var full_line := ""

func _ready():
	visible = false
	show_next_line()

func show_next_line():
	if current_line < lines.size():
		visible = true
		full_line = lines[current_line]
		current_line += 1
		await typewriter_effect(full_line)
	else:
		get_tree().change_scene_to_file("res://game_space.tscn")

func _input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if is_typing:
			text = full_line
			is_typing = false
		else:
			show_next_line()

func typewriter_effect(line: String, delay: float = 0.02):
	is_typing = true
	text = ""
	for char in line:
		if not is_typing:
			break
		text += char
		await get_tree().create_timer(delay).timeout
	is_typing = false
