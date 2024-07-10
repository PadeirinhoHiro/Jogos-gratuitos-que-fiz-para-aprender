extends CanvasLayer

func _on_button_pressed():
	call_deferred("go_to_menu")
	
	
func go_to_menu():
	get_tree().change_scene_to_file("res://Menu/main_menu.tscn")



func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
