extends Area2D

signal add_point(amount)
var amount : int

func _ready():
	if transform.x.x < 0:
		$AnimationPlayer.play("Reverse_Swing")
	if transform.x.x > 0:
		$AnimationPlayer.play("Swing")
func _on_body_entered(body):
	if body.is_in_group("enemy"):
		if body.is_in_group("crawler"):
			amount = 1
		if body.is_in_group("snake"):
			amount = 2
		if body.is_in_group("spider"):
			amount = 3
		if body.is_in_group("angel"):
			amount = 4
		if body.is_in_group("boss"):
			amount = 100
			body.call("spawn_time_potion")
		Globals.score += amount
		body.queue_free()
