extends Node

var Potions : Dictionary = {
	"Poison":0
	,"Speed":0
	,"Fire":0
	,"Live":0
	}
var Potions_keys : Array = Potions.keys()
var index : int = 0
var current_potion : String
var current_potion_quantity := 0
var current_effect : String
var can_use_item : bool = true
var inventory_limit := 1
var effects_List : Dictionary = {
	"Poison":false
	,"Speed":55
	,"Fire":false
	,"Live":1
}
var effects_List_keys = effects_List.keys()
var player




func _process(_delta):
	for i in effects_List_keys:
		if effects_List[i] is bool:
			if effects_List[i] == true:
				if i == "Poison":
					Globals.poison_resistance = true
				if i == "Fire":
					Globals.fire_resistance = true
			else:
				if i == "Poison":
					Globals.poison_resistance = false
				if i == "Fire":
					Globals.fire_resistance = false
func _ready():
	for i in Potions_keys:
		Potions[i] = 0
		print(Potions)
	current_potion = Potions_keys[randi() % Potions_keys.size()]
	%UI.call("update_the_values",current_potion,Potions[current_potion])
func _input(event):
	if event.is_action_pressed("jogo_trocar_current_potion (to_left)"):
		index -= 1
		if abs(index) >= Potions_keys.size():
			index = 0
		current_potion = Potions_keys[index]
	if event.is_action_pressed("jogo_trocar_current_potion (to_right)"):
		index += 1
		if abs(index) >= Potions_keys.size():
			index = 0
		current_potion = Potions_keys[index]
	if event.is_action_pressed("jogo_usar_item"):
		if can_use_item:
			if Potions[current_potion] > 0:
				can_use_item = false
				Potions[current_potion] -= 1
				current_effect = current_potion
				start_effect(current_effect)
			else:
				%UI.call("um_toque_para_o_burro")
	%UI.call("update_the_values",current_potion,Potions[current_potion])


func start_effect(potion):
	if effects_List[potion] is bool:
		effects_List[potion] = true
	elif effects_List[potion] is int:
		if potion == "Live":
			Globals.player_lives += effects_List[potion]
			%UI.call("update_the_live")
		if potion == "Speed":
			print("test")
			Globals.player_speed += effects_List[potion]
	$Effect_Timer.start()
	%Countdown.start()
	

func _on_effect_timer_timeout():
	can_use_item = true
	for i in effects_List_keys:
		if effects_List[i] is bool:
			effects_List[i] = false
		if i == "Speed":
			Globals.player_speed = Globals.player_normal_speed


func _on_poison_area_body_entered(body):
	if body.is_in_group("player"):
		player = body
		if Globals.poison_resistance == true:
			print("ta imune")
		else:
			player.call("player_death")


func _on_fire_area_body_entered(body):
	if body.is_in_group("player"):
		player = body
		if Globals.fire_resistance == true:
			pass
		else:
			player.call("player_death")


func _use_item(item : String):
	Potions[item] += 1
	if Potions[item] > inventory_limit:
		Potions[item] = inventory_limit
	if current_potion == item:
		current_potion_quantity = Potions[item]
		%UI.call("update_the_values",current_potion,current_potion_quantity)


