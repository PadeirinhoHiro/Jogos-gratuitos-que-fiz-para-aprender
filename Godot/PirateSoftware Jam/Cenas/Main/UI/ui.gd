extends CanvasLayer

@export var aviso : PackedScene
var Potions_Textures : Dictionary = {
	"Poison":"res://Sprites em PNG E GIF/Items/pote de veneno.png"
	,"Live":"res://Sprites em PNG E GIF/Items/pote de vida.png"
	,"Fire":"res://Sprites em PNG E GIF/Items/pote de fogo.png"
	,"Speed":"res://Sprites em PNG E GIF/Items/pote de velocidade.png"
	}
var countdown := 12

func _process(delta):
	update_score()

func update_the_values(values,quantity):
	$Current_Potion.text = str(values)+" : "+str(quantity)
	$Current_Potion/Potions.set_texture(load(Potions_Textures[values]))


func update_the_live():
	$Lives.text = str(Globals.player_lives)
	$Lives/Heart.frame = 3 - Globals.player_lives


func um_toque_para_o_burro():
	var aviso_node = aviso.instantiate()
	add_child(aviso_node)

func update_score():
	$Score.text = "Score : "+str(Globals.score)


func _on_countdown_timeout():
	countdown -= 1
	if countdown >= 0:
		$Remaing_Effect_Timer.text = str(countdown)
	else:
		$Countdown.stop()
		countdown = 12
		$Remaing_Effect_Timer.text = str(countdown)
