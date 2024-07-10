extends CharacterBody2D
class_name Enemy

var acceleration = 50
var player = null
var gravity = 16.8
var max_speed = 150
var friction = 0.3
signal enemy_death
func _physics_process(_delta):
	velocity.y += gravity
	if is_on_floor():
		if player:
			if player.position.x > self.position.x:
				velocity.x += acceleration
				$Sprite2D.flip_h = true
			if player.position.x < self.position.x:
				velocity.x -= acceleration
				$Sprite2D.flip_h = false
			velocity.x = clamp(velocity.x,-max_speed,max_speed)
		velocity.x = lerp(velocity.x,0.0,friction)
	var collision = move_and_slide()
	if collision:
		var collider = get_last_slide_collision().get_collider()
		if collider.is_in_group("Player"):
			collider.respawn()

func _on_area_2d_body_entered(body):
	player = body


func _on_area_2d_body_exited(_body):
	player = null


func _on_death_body_entered(body):
	if body.is_in_group("player"):
		body.velocity.y -= 450
		body.move_and_slide()
		enemy_death.emit()
		queue_free()
