extends CharacterBody2D

const CRAWLER_SPEED : int = 700
var player : Node2D = null
const GRAVITY : int = 100
var directions : Array = [-1,1]
var random_dir : int
var friction : float = 5

func _on_root_state_processing(delta):
	if is_on_floor():
		velocity.x = lerp(velocity.x,0.0,1-exp(-delta*friction))
	velocity.y += GRAVITY * delta
	move_and_slide()

func _on_crawler_vision_body_entered(body):
	if body.is_in_group("player"):
		player = body
		$StateChart.send_event("Start_The_Chase")
	else:
		return

func _on_chase_state_processing(delta):
	if player:
		var direction_to_chase : Vector2 = (player.global_position - self.global_position).normalized()
		flip_based_on_velocity()
		#print(direction_to_chase.x)
		$Walk_Animation.play("Walk")
		velocity.x = CRAWLER_SPEED * direction_to_chase.x * delta
		#print(velocity.x)
		var collision_info = move_and_slide()
		if collision_info:
			var collider = get_last_slide_collision().get_collider()
			if collider.has_method("player_death"):
				collider.call("player_death")
		
	else:
		var player_placeholder = get_tree().get_first_node_in_group("player") as Node2D
		if self.global_position.distance_squared_to(player_placeholder.global_position) > pow(66,2):
			$StateChart.send_event("Start_The_Wander")
func _on_crawler_vision_body_exited(_body):
	player = null
	$StateChart.send_event("Start_The_Wander")

func _on_wander_state_entered():
	$Wander_Time.set_wait_time(randi_range(1,3))
	$Wander_Time.start()
	$Walk_Animation.stop()
	if player:
		$StateChart.send_event("Start_The_Chase")


func _on_wander_time_timeout():
	$StateChart.send_event("Start_Wandering")

func _on_wandering_state_entered():
	$Wandering_Time.set_wait_time(randi_range(1,3))
	$Wandering_Time.start()
	random_dir = directions[randi_range(0,1)]

func _on_wandering_state_processing(delta):
	var wandering_direction_x = random_dir
	if player:
		$StateChart.send_event("Start_The_Chase")
	else:
		var correct_direction = ray_is_colliding()
		if correct_direction != 0:
			velocity.x = CRAWLER_SPEED * delta * correct_direction
		else:
			velocity.x = CRAWLER_SPEED * delta * wandering_direction_x
		$Walk_Animation.play("Walk")
		#print(correct_direction)
		flip_based_on_velocity()
		move_and_slide()

###########################################
func flip_horizontal(x_direction : float):
	if x_direction < 0:
		return false
	elif x_direction > 0:
		return true
	else:
		return $Walk_Animation.is_flipped_h()
		
		
func flip_based_on_velocity():
	if velocity.x > 0:
		$Sprite2D.scale.x = -1
	if velocity.x < 0:
		$Sprite2D.scale.x = 1
func ray_is_colliding():
	if !$Raio_Esquerda.is_colliding():
		return 1
	elif !$Raio_Direita.is_colliding():
		return -1
	else:
		return 0
###########################################
func _on_wandering_time_timeout():
	$StateChart.send_event("Start_The_Wander")


