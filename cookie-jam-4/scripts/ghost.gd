extends Node2D

var t = 200
func _physics_process(delta: float) -> void:
	position.y-=5
	t-=1
	if t == 0:
		queue_free()
