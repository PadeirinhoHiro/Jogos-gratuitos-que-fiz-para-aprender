extends Area2D

var speed = 100
var direction = Vector2.UP

func _process(delta):
	position += speed * delta * direction
	scale.x = direction.normalized().x * (-1)
func _on_projectile_timelive_timeout():
	queue_free()


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.respawn()
