extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	position += Vector2.UP*10


func _on_death_timeout() -> void:
	queue_free()
