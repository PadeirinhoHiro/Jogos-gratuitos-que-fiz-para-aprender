extends CanvasLayer

func _ready():
	$Level_2.hide()
	$Level_3.hide()
	if Globals.level_1_finished:
		$Level_2.show()
	if Globals.level_2_finished:
		$Level_3.show()


func _on_return_pressed():
	get_tree().change_scene_to_file("res://Menu/main_menu.tscn")

func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")

func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://Levels/level_2.tscn")

func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://Levels/level_3.tscn")


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
