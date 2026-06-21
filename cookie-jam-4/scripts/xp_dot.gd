extends Node2D

var t = 0
func _physics_process(delta: float) -> void:
	t+=0.2*Engine.time_scale
	var towardsPlayer = get_parent().get_node("player").anchorPos - global_position
	position += towardsPlayer.normalized()*t*Engine.time_scale
