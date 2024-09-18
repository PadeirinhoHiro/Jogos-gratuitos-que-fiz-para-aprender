extends Node

@onready var shadow_nodes = get_tree().get_nodes_in_group("shadow") as Array
var frame_count : int= 0
func _on_cobrao_frame_changed():
	shadow_nodes[frame_count].hide()
	frame_count += 1
	if frame_count > shadow_nodes.size():
		frame_count = 0
