extends CharacterBody2D

var MAX_VELOCITY : float = Globals.player_speed
const ACCELERATION : float = 7.5
const JUMP_FORCE : int = -65
const GRAVITY : float = 100
const friction : float = 5
var jump_count : int = 0
var can_swing = true
@export var sword_scene : PackedScene
signal i_am_dead

func _on_actions_state_input(_event):
	MAX_VELOCITY = Globals.player_speed
	if Input.is_action_pressed("jogo_tiro_primário") and can_swing == true:
		$StateChart.send_event("player_will_sword_attack")
	if Input.is_action_pressed("jogo_mov_direita") or Input.is_action_pressed("jogo_mov_esquerda"):
		$StateChart.send_event("player_want_movement")
	if Input.is_action_just_pressed("jogo_mov_pulo") and is_on_floor():
		$StateChart.send_event("player_want_jumping")

func _on_walking_state_processing(delta):
	var direction : float = Input.get_axis("jogo_mov_esquerda","jogo_mov_direita")
	var velocity_i_want : float = direction * MAX_VELOCITY
	velocity.x = lerp(velocity.x,velocity_i_want,1-exp(-delta*ACCELERATION))
	if is_on_floor():
		jump_count = 0
		if direction == 0:
			velocity.x = lerp(velocity.x, 0.0, 1-exp(-delta*friction))
			$StateChart.send_event("player_want_idle")
	look_for_the_mouse()
	##########
	move_and_slide()
	print("GLOBAL_SPEED"+str(Globals.player_speed))
	print("MAX_VELOCITY"+str(MAX_VELOCITY))
	print("Velocity x"+str(velocity.x))


func _on_attacking_state_entered():
	$Sprite.frame = 1
	var sword = sword_scene.instantiate() as Node2D
	sword.scale.x = return_direction()
	if sword.scale.x < 1:
		sword.position = $Right_To_Left.position
	if sword.scale.x == 1:
		sword.position = $Left_To_Right.position
	add_child(sword)
	can_swing = false
	$StateChart.send_event("sword_cooldown_start")
	


func _on_recharging_state_entered():
	$Sprite.frame = 0
	$Sword_CD.start()


func _on_falling_state_processing(_delta):
	if is_on_floor():
		$StateChart.send_event("player_is_on_ground")



func _on_falling_state_input(_event):
	if Input.is_action_just_pressed("jogo_mov_pulo"):
		$StateChart.send_event("player_want_double_jumping")

func _on_jumping_state_entered():
	if jump_count <= 1:
		print(jump_count)
		velocity.y = JUMP_FORCE
		jump_count += 1
		move_and_slide()
	$StateChart.send_event("player_will_fall")
	#print(jump_count)


func _on_movement_state_processing(delta):
	velocity.y += GRAVITY * delta
	move_and_slide()
	if !is_on_floor():
		$StateChart.send_event("player_will_fall")
	if Input.is_action_just_pressed("jogo_mov_pulo") and is_on_floor():
		$StateChart.send_event("player_want_jumping")

##########    CUSTOM FUNCTIONS                                #####################################
func look_for_the_mouse():
	var looking_direction = return_direction()
	$Sprite.transform.x.x = looking_direction
	$LightOccluder2D.transform.x.x = looking_direction

func return_direction():
	var direction_to_look = (get_global_mouse_position() - global_position).normalized().x
	if direction_to_look < 0:
		direction_to_look = floor(direction_to_look)
	if direction_to_look > 0:
		direction_to_look = ceil(direction_to_look)
	
	return direction_to_look


###############    TIMEOUTS                 #################################
func _on_sword_cd_timeout():
	$StateChart.send_event("back_to_normal")
	can_swing = true

############## DEATH MANAGER ###############################
func player_death():
	i_am_dead.emit()


