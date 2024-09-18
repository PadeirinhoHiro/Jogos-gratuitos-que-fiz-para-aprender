extends CanvasLayer

func _on_start_pressed():
	call_deferred("start_the_game")

func _on_select_pressed():
	call_deferred("go_to_select_menu")



func start_the_game():
	get_tree().change_scene_to_file("res://Cenas/Main/Level_1.tscn")

func go_to_select_menu():
	get_tree().change_scene_to_file("res://Cenas/Main/Main Menu/select_menu.tscn")
