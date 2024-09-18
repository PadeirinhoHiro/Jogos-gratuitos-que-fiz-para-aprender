extends Area2D
signal use_item
var potion := "Live"

func _on_body_entered(body):
	if body.is_in_group("player"):
		use_item.emit(potion)
		queue_free()
