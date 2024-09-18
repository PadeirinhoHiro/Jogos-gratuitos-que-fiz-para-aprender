extends Node

func _on_finish_zone_body_entered(body):
	if body.is_in_group("player"):
		call_deferred("go_to_next_level")


func _on_death_zone_body_entered(body):
	if body.is_in_group("player"):
		body.player_death()


func go_to_next_level():
	get_tree().change_scene_to_file("res://Cenas/Main/level_2.tscn")
