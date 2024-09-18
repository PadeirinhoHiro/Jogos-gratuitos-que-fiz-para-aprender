extends CharacterBody2D

const SPIDER_SPEED = 2000


var player

func _on_tooth_body_entered(body):
	if body.is_in_group("player"):
		if "player_death" in body:
			body.player_death()


func _on_vision_body_entered(body):
	if body.is_in_group("player"):
		player = body
		$StateChart.send_event("start_chase")



func _on_vision_body_exited(body):
	if body.is_in_group("player"):
		player = null
		$StateChart.send_event("go_chill")


func _on_chase_state_processing(delta):
	print("chase")
	if player:
		var direction_to_face : Vector2 = (player.global_position-self.global_position).normalized()
		look_at(player.global_position)
		velocity = direction_to_face * SPIDER_SPEED * delta
		move_and_slide()
		$Animation.play("walking")


func _on_chill_state_entered():
	$Sprite2D.frame = 0
	$"Shadows/First Frame".visible = true
	$"Shadows/Second Frame".visible = false
	$"Shadows/Third Frame".visible = false
	if player:
		$StateChart.send_event("start_chase")
