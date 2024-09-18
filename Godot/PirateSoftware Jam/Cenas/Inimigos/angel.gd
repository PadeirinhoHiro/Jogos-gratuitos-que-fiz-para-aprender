extends CharacterBody2D


const GRAVITY : int = 100
var player
@export var sword_scene : PackedScene

func _on_vision_body_entered(body):
	if body.is_in_group("player"):
		player = body
		$StateChart.send_event("player_entered_vision")


func _on_vision_body_exited(body):
	if body.is_in_group("player"):
		player = body
		$StateChart.send_event("player_escaped_vision")


func _on_sword_chasing_state_entered():
	$Sword_Chase_Timer.start()

func _on_sword_chasing_state_processing(delta):
	if player:
		$Sword_Spawn.global_position.x = player.global_position.x
		$Sword_Spawn.global_position.y = player.global_position.y - 125
	else:
		$StateChart.send_event("player_escaped_vision")

func _on_sword_chase_timer_timeout():
	$StateChart.send_event("finished_the_chase")


func _on_sword_spawning_state_entered():
	var sword_node : Node2D = sword_scene.instantiate()
	sword_node.position = $Sword_Spawn.position
	add_child(sword_node)
	$StateChart.send_event("finished_the_attack")


func _on_root_state_processing(delta):
	velocity.y += GRAVITY * delta
	move_and_slide()
