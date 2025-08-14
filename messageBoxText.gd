extends RichTextLabel

var lines = [
	"Click on Doki to give her a smooch! There will be a short delay before you can click her again.",
	"Tomatos and Dragoons will spawn randomly. Click on them to increase your score and combo multiplier",
	"The combo Multiplier will break if you do not click on a target after 3 seconds.",
	"Fill up the bar to win the game!"
]

var current_line = 0

func _ready():
	visible = false
	show_next_line()

func show_next_line():
	if current_line < lines.size():
		visible = true
		await typewriter_effect(lines[current_line])
		current_line += 1
	else:
		get_tree().change_scene_to_file("res://game_space.tscn")

func _input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		show_next_line()

func typewriter_effect(line: String, delay: float = 0.02):
	text = ""
	for char in line:
		text += char
		await get_tree().create_timer(delay).timeout
