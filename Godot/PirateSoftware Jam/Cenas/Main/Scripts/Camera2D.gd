extends Camera2D

var suavidade := 15

func _ready():
	define_limits()

func _process(delta):
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player:
		var target_position = player.global_position
		global_position = lerp(global_position,target_position,1-exp(-delta*suavidade))

func define_limits():
	if %Plataforms:
		var map_limits = %Plataforms.get_used_rect()
		var map_cellsize = %Plataforms.get_tileset().get_tile_size()
		limit_top = map_limits.position.y * map_cellsize.y
		limit_bottom = map_limits.end.y * map_cellsize.y
		limit_left = map_limits.position.x * map_cellsize.x
		limit_right = map_limits.end.x * map_cellsize.x
	
