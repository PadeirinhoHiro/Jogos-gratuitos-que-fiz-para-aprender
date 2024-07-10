extends Area2D

var rotation_speed = 5
var speed : int = 175
var direction = Vector2.UP
func _process(delta):
	rotation += rotation_speed * delta
	direction = direction
	position += speed * direction * delta
	scale += Vector2(0.09,0.9) * delta

func _on_knife_time_live_timeout():
	queue_free()


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.respawn()
