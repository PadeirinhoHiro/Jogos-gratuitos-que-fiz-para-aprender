extends level_script


func _on_finish_zone_body_entered(_body):
	call_deferred("change_level")

func change_level():
	Globals.level_1_finished = true
	get_tree().change_scene_to_file("res://Levels/level_2.tscn")



func _on_first_level_song_finished():
	$First_Level_Song.play()
