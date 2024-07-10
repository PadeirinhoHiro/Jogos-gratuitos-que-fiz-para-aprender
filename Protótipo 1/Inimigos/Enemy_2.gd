extends CharacterBody2D

var can_shoot : bool = true
var player
signal bullet
var gravity = 16.8
signal enemy_death
func _physics_process(_delta):
	velocity.y += gravity
	if player:
		if player.position.x > self.position.x:
			transform.x.x = -1
		if player.position.x < self.position.x:
			transform.x.x = 1
		if can_shoot:
			var bullet_start_pos = $Gun_Pos.global_position
			var bullet_direction = (bullet_start_pos - self.position).normalized()
			bullet.emit(bullet_start_pos,bullet_direction)
			can_shoot=false
			$Shoot_CD.start()
		move_and_collide(velocity)


func _on_area_2d_body_entered(body):
	player = body
	
func _on_area_2d_body_exited(_body):
	player = null

func _on_shoot_cd_timeout():
	can_shoot = true

func _on_death_body_entered(body):
	if body.is_in_group("player"):
		body.velocity.y -= 450
		body.move_and_slide()
		enemy_death.emit()
		queue_free()
