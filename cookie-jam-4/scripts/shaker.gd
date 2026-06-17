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
	position = Vector2(randf_range(-intensity, intensity),randf_range(-intensity,intensity))
	if turns == 0:
		cam.position_smoothing_speed = defaultCamSpeed
		$shakeCD.stop()
		position = Vector2.ZERO
