extends level_script



func _on_finish_game_body_entered(body):
	call_deferred("finish_game")


func finish_game():
	get_tree().change_scene_to_file("res://End/finish_message.tscn")


func _on_final_level_song_finished():
	$Final_Level_Song.play()
