extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.frame = randi_range(1,5)*5
	$shadow.frame = $Sprite2D.frame

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	z_index = global_position.y/100.0
