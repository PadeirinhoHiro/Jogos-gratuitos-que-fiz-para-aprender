extends Area2D
signal use_item
var potion := "Speed"
var can_use := true
var countdown := 15

func _on_body_entered(body):
	if body.is_in_group("player"):
		if can_use == true:
			use_item.emit(potion)
			$Sprite2D.hide()
			can_use = false
			$Respawn_Timer.start()
			$Countdown.start()
			countdown = 15


func _on_respawn_timer_timeout():
	can_use = true
	$Sprite2D.show()


func _on_countdown_timeout():
	if countdown == 15:
		$Counter.text = str(countdown)
	countdown -= 1
	if countdown > 0:
		$Counter.text = str(countdown)
	else:
		$Counter.text = ""
		$Countdown.stop()
