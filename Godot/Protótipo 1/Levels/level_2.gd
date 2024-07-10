extends level_script

func _on_finish_zone_body_entered(_body):
	call_deferred("change_level")
	
func change_level():
	Globals.level_2_finished = true
	get_tree().change_scene_to_file("res://Levels/level_3.tscn")

func _on_second_level_song_finished():
	$Second_Level_Song.play()
