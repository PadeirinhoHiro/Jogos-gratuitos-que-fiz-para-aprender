extends Node

func finish_game(body):
	if body.is_in_group("player"):
		call_deferred("finish_the_prototype")

func secret_finish(body):
	if body.is_in_group("player"):
		call_deferred("Test_Level")


func death_player(body):
	if body.is_in_group("player"):
		body.player_death()


func finish_the_prototype():
	get_tree().change_scene_to_file("res://Cenas/END/END_SCENE.tscn")

func Test_Level():
	get_tree().change_scene_to_file("res://Cenas/Main/Prototype.tscn")
