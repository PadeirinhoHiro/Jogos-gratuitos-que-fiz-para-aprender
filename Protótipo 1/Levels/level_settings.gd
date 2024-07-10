extends Node2D
class_name level_script

var player : PackedScene = preload("res://Player/Player.tscn")
var you_died_scene : PackedScene = preload("res://UI/you_died.tscn")
var projectile : PackedScene = preload("res://Projectiles/projectile.tscn")
var knife : PackedScene = preload("res://Projectiles/Knife.tscn")
signal death_message

func _ready():
	%Player.position = $Start_pos.position
	update_display()
	$Enemy_1_Placeholder.queue_free()
	$Enemy_2_Placeholder.queue_free()
	$Boss_Placeholder.queue_free()

func _on_fall_zone_body_entered(body):
	if "player" in body:
		body.call_deferred("respawn")
	else:
		body.queue_free()

func _on_player_player_death():
	if Globals.health_count > 0:
		Globals.health_count -= 1
		Globals.current_boss_health = 3
		death_message.emit()
		%Player.position = $Start_pos.position
		update_display()
	else:
		call_deferred("state_zero")
		call_deferred("main_menu")

func _on_death_message():
	var you_died_canvaslayer : CanvasLayer = you_died_scene.instantiate()
	add_child(you_died_canvaslayer)
	$Death_Song.play()

func main_menu():
	get_tree().change_scene_to_file("res://Menu/main_menu.tscn")

func _on_bread_coin_body_entered(_body):
	Globals.bread_count += 1
	update_display()


func _on_enemy_1_enemy_death():
	Globals.bread_count += 1
	update_display()


func _on_enemy_2_bullet(pos,direction):
	var bullet = projectile.instantiate()
	bullet.position = pos
	bullet.direction = direction
	add_child(bullet)

func state_zero():
	Globals.health_count = 3
	Globals.bread_count = 0
	Globals.current_boss_health = 3
	
func update_display():
	$UI/Death_Display.text = "Lives = "+str(Globals.health_count)
	$UI/Bread_Display.text = "Breads = "+str(Globals.bread_count)
func _on_boss_placeholder_knife(pos,direction):
	var knife_node = knife.instantiate()
	knife_node.position = pos
	knife_node.direction = direction
	add_child(knife_node)


func _on_boss_placeholder_boss_death():
	Globals.bread_count += 100
	update_display()
