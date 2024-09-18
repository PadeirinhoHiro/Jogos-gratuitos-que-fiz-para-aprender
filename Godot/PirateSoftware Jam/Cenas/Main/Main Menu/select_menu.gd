extends CanvasLayer



func _on_level_1_pressed():
	call_deferred("level_1")


func _on_level_2_pressed():
	call_deferred("level_2")


func _on_prototype_pressed():
	call_deferred("prototype")

func level_1():
	get_tree().change_scene_to_file("res://Cenas/Main/Level_1.tscn")
	
func level_2():
	get_tree().change_scene_to_file("res://Cenas/Main/level_2.tscn")
	
func prototype():
	get_tree().change_scene_to_file("res://Cenas/Main/Prototype.tscn")
