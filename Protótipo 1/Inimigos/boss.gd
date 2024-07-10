extends CharacterBody2D

var initial_boss_health = 3.0
var boss_acceleration = 25
var boss_max_speed = 100
var can_shoot = true
var friction = 0.3
signal boss_death
signal knife
var player
var gravity = 1

func _ready():
	$Bar/Health_bar.size.x = 32 * (Globals.current_boss_health/initial_boss_health)

func _physics_process(_delta):
	if player:
		if player.position.x > self.position.x:
			transform.x.x = -1
			velocity.x += boss_acceleration
		if player.position.x < self.position.x:
			transform.x.x = 1
			velocity.x -= boss_acceleration
		if can_shoot:
			var knives_start_positions = $Hands_Pos.get_children()
			var selected_knife_start_position = knives_start_positions.pick_random()
			var knife_direction = (player.global_position - self.global_position).normalized()
			knife.emit(selected_knife_start_position.global_position,knife_direction)
			can_shoot = false
			$Knife_CD.start()
	if is_on_floor():
		velocity.x = lerp(velocity.x,0.0,friction)
	############################################
	velocity.x = clamp(velocity.x,-boss_max_speed,boss_max_speed)
	velocity.y += gravity
	############################################
	var collision = move_and_slide()
	if collision:
		var collider = get_last_slide_collision().get_collider()
		if collider.is_in_group("player"):
			collider.respawn()
func _on_vision_cos_body_entered(body):
	player = body

func _on_vision_cos_body_exited(_body):
	player = null


func _on_death_cos_body_entered(body):
	if body.is_in_group("player"):
		if Globals.current_boss_health > 1:
			body.velocity.y -= 450
			body.move_and_slide()
			Globals.current_boss_health -= 1
			$Bar/Health_bar.size.x = 32 * (Globals.current_boss_health/initial_boss_health)
		else:
			boss_death.emit()
			queue_free()


func _on_knife_cd_timeout():
	can_shoot = true
