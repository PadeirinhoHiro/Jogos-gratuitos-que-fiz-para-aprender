extends CharacterBody2D

var gravity = 19.6
var speed = 70
var jump_pushback = speed *  6
var max_velocity : int = 175
var friction = 0.1
var jump_force = 450
var wall_jump : float = jump_force * 0.75
var player : bool = true
var wall_gravity = gravity/1.25
var jump_count = 0
signal player_death


func _physics_process(delta):
	###############################################################
	var input_dir = Input.get_axis("Esquerda","Direita")
	velocity.x += speed * input_dir
	if Input.is_action_just_pressed("Pulo") and is_on_floor():
		jump()
	if Input.is_action_just_pressed("Pulo") and jump_count < 1 and !is_on_floor():
		double_jump()
	if is_on_floor():
		velocity.x = lerp(velocity.x,0.0,friction)
		jump_count = 0
	if velocity.x == 0:
		idle_state()
	if velocity.x != 0 or velocity.y != 0:
		$Sprite2D.frame = 0
	velocity.y += gravity
	velocity.x = clamp(velocity.x,-max_velocity,max_velocity)
	if is_on_wall() and Input.is_action_just_pressed("Pulo"):
		wall_jump_func()
	if is_on_wall() and !is_on_floor():
		if Input.is_action_pressed("Direita") or Input.is_action_pressed("Esquerda"):
			wall_slide()
	###############################################################
	move_and_slide()
	###############################################################


func wall_slide():
	velocity.y -= wall_gravity
	velocity.y = min(velocity.y,wall_gravity)
	
func jump():
	velocity.y -= jump_force
	jump_count += 1
	
func double_jump():
	velocity.y = 0
	velocity.y -= jump_force
	jump_count += 1
func wall_jump_func():
	velocity.y -= wall_jump
	velocity.x += jump_pushback * get_wall_normal().x

func idle_state():
	$AnimationPlayer.play("Idle")
	

func respawn():
		player_death.emit()
