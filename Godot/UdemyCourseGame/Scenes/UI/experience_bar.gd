extends CanvasLayer

@export var exp_manager : Node
@onready var progress_bar = $MarginContainer/ProgressBar

func _ready():
	exp_manager.experience_updated.connect(on_experience_updated)
	progress_bar.value = 0


func on_experience_updated(current_exp : float, target_exp : float):
	var percent = current_exp / target_exp
	progress_bar.value = percent
