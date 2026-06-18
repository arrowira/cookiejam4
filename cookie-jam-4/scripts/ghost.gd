extends Node2D

var t = 200.0
var maxT = 200.0

func _ready() -> void:
	maxT = t
	

func _physics_process(delta: float) -> void:
	$Icon.get_material().set_shader_parameter("alpha", t/maxT)
	
	position.y-=5
	t-=1
	if t == 0:
		queue_free()
