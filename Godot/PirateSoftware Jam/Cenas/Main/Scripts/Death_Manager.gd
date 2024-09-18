extends Node

func _ready():
	Globals.player_lives = 3
	%UI.call("update_the_live")

func _on_death_zone_body_entered(body):
	if body.is_in_group("player"):
		body.player_death()
	else: 
		queue_free()

func _on_player_i_am_dead():
	Globals.player_lives -= 1
	Globals.score = 0
	%UI.call("update_score")
	%UI.countdown = 0
	if Globals.player_lives <= 0:
		call_deferred("main_menu_ocasion_death")
	%Pos_Manager.get_back_to_start()
	%UI.call("update_the_live")


func main_menu_ocasion_death():
	get_tree().change_scene_to_file("res://Cenas/Main/Main Menu/Main Menu.tscn")
