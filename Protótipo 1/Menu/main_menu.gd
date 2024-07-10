extends CanvasLayer



func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")



func _on_select_button_pressed():
	get_tree().change_scene_to_file("res://UI/select_level.tscn")

func _on_exit_button_pressed():
	get_tree().quit()


func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()
