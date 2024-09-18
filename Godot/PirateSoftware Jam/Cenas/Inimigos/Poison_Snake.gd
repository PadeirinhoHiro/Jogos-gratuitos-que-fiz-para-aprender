extends CharacterBody2D
##
const GRAVITY : int = 100

##
var player

##

var can_shoot : bool = true
@export var poisonProjectile : PackedScene

func _on_root_state_processing(delta):
	velocity.y += GRAVITY * delta
	move_and_slide()
	if player:
		self.transform.x.x = ceil_floor_function((player.global_position - global_position).normalized().x)
		var collider = get_last_slide_collision()
		if collider == player:
			player.player_death()
func _on_vision_body_entered(body):
	if body.is_in_group("player"):
		player = body
		$StateChart.send_event("player_entered_snake_vision")

func _on_vision_body_exited(body):
	if body.is_in_group("player"):
		player = null
		$StateChart.send_event("player_escaped_snake_vision")


func _on_poison_cd_timeout():
	can_shoot = true
	$Sprite2D/Shadows/Frame_8.hide()
	$Sprite2D/Shadows/Frame_1.show()
	$Sprite2D.frame = 0

func _on_attacking_state_processing(_delta):
	if player:
		if can_shoot:
			can_shoot = false
			%Animation.play("Attack")
			%Poison_CD.start()
			%Snake_Attack.start()


func _on_snake_attack_timeout():
	if player:
		var direction_to_shoot = (player.global_position - global_position).normalized()
		var poison_shoot = poisonProjectile.instantiate() as Node2D
		poison_shoot.direction.x = -ceil_floor_function(direction_to_shoot.x)
		poison_shoot.direction.y = 0
		poison_shoot.rotation_degrees = -ceil_floor_function(direction_to_shoot.x) * 90
		poison_shoot.global_position = $Snake_Mouth.global_position
		get_tree().root.add_child(poison_shoot)
	$Animation.stop()

func ceil_floor_function(arg):
	if arg < 0:
		arg = floor(arg)
	if arg > 0:
		arg = ceil(arg)
	return -arg


func _on_chilling_state_entered():
	$Sprite2D/Shadows/Frame_8.hide()
	$Sprite2D/Shadows/Frame_1.show()

