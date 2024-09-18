extends Node

var player
var start_pos
func _ready():
	player = get_tree().get_first_node_in_group("player") as Node2D
	start_pos = get_tree().get_first_node_in_group("start_pos") as Node2D
	
	if player and start_pos:
		player.global_position = start_pos.global_position


func get_back_to_start():
	if player and start_pos:
		player.global_position = start_pos.global_position
