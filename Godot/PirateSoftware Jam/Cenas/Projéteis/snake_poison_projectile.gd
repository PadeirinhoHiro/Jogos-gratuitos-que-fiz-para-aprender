extends Area2D

var direction : Vector2 = Vector2.UP
var speed := 95

func _ready():
	$Projectile_LifeTime.start()

func _process(delta):
	position += speed * direction * delta


func _on_body_entered(body):
	if body.is_in_group("player"):
		if "player_death" in body:
			if Globals.poison_resistance == true:
				queue_free()
				
			else:
				body.call("player_death")
				queue_free()
				


func _on_projectile_life_time_timeout():
	queue_free()
