extends TextureProgressBar

var max_score: int = 3000
var kiss_score_node

func _ready():
	value = 0
	max_value = max_score
	
	kiss_score_node = get_node_or_null("/root/GameSpace/KissScore/CanvasLayer/KissScoreLabel")
	if kiss_score_node:
		kiss_score_node.connect("score_updated", Callable(self, "_on_score_update"))
	else:
		print("error")

func _on_score_update(new_score: int) -> void:
	value = clamp(new_score, 0, max_score)
