extends Node2D

@onready var cam = $Camera2D
var defaultCamSpeed = 0

var turns = 0
var intensity = 0

func _ready() -> void:
	defaultCamSpeed = cam.position_smoothing_speed

func shake(length, i):
	intensity = i
	turns = length
	$shakeCD.start()
	cam.position_smoothing_speed = 20
	

func _on_shake_cd_timeout() -> void:
	turns -= 1
	var rand = 10*randf()
	position = (intensity/turns)*Vector2(cos(rand),sin(rand))
	if turns == 1:
		cam.position_smoothing_speed = defaultCamSpeed
		$shakeCD.stop()
		position = Vector2.ZERO
