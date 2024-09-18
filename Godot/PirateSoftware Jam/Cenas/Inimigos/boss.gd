extends CharacterBody2D

@export var time_potion_scene : PackedScene
var slowdown_value_x : float = 0.6
var slowdown_value_y : float = 0.9
var player
const GRAVITY : int = 100
func _on_zone_body_entered(body):
	if body.is_in_group("player"):
		player = body
		$StateChart.send_event("slow_player")

func _on_zone_body_exited(body):
	if body.is_in_group("player"):
		player = null
		$StateChart.send_event("go_chill")


func _on_slowdown_state_processing(delta):
	if player:
		player.velocity.x *= slowdown_value_x
		player.velocity.y *= slowdown_value_y
		player.move_and_slide()

func _on_root_state_processing(delta):
	velocity.y += GRAVITY * delta
	move_and_slide()

func spawn_time_potion():
	var time_potion = time_potion_scene.instantiate() as Node2D
	time_potion.global_position = self.global_position
	time_potion.global_position.y -= 32
	get_parent().add_child(time_potion)
