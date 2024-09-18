extends Area2D

const SWORD_SPEED : int = 100
var direction : Vector2 = Vector2.DOWN
func _ready():
	$Lifetime.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * SWORD_SPEED * delta


func _on_lifetime_timeout():
	call_deferred("queue_free")
