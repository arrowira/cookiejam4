extends Node2D

var t = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	t+=1
	scale = Vector2(1,1)*(1.5+sin(t/10.0)/4.0)
