extends Node2D

@onready var audio_player = $AudioStreamPlayer2D

func _ready():
	audio_player.autoplay = true
