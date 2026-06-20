extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.frame = randi_range(1,5)*5
	z_index = global_position.y/100.0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$shadow.frame = $Sprite2D.frame

func _break():
	$break.pitch_scale = 1.0 + randf()/5.0
	$break.play()
	z_index = -1000
	$body.queue_free()
	$CPUParticles2D.emitting = true
	$Sprite2D.frame = randi_range(1,4)*5+3
