extends CanvasLayer

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Cenas/Main/Main Menu/Main Menu.tscn")


func _on_timer_timeout():
	$Button.show()
