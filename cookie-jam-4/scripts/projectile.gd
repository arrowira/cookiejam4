extends Area2D

var speed = 50
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	position += speed*Vector2(-cos(rotation), -sin(rotation))
	
	#friction
	speed*=0.99
	


func _on_death_timeout() -> void:
	queue_free()
