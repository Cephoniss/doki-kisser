extends Button
@onready var audio_player = $"../../AudioStreamPlayer2D"

func _ready():
	$".".pressed.connect(Callable(self, "_on_button_pressed"))
	
func _on_button_pressed(delay: float = 0.7):
	audio_player.play()
	await get_tree().create_timer(delay).timeout
	BGM.audio_player.play()
	get_tree().change_scene_to_file("res://mgs_call.tscn")
