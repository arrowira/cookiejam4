extends Node2D

@onready var cam = $Camera2D
var defaultCamSpeed = 0

var turns = 0
var intensity = 0
var t = 0

func _ready() -> void:
	defaultCamSpeed = cam.position_smoothing_speed
	
func hit():
	shake(4, 20)
	timestop()

func shake(length, i):
	intensity = i
	turns = length
	$shakeCD.start()
	cam.position_smoothing_speed = 20

func _physics_process(delta: float) -> void:
	if t != 0:
		t-=1
	else:
		Engine.time_scale = 1
		get_parent().get_parent().frozen=false
	

func _on_shake_cd_timeout() -> void:
	turns -= 1
	var rand = 10*randf()
	position = (intensity/turns)*Vector2(cos(rand),sin(rand))
	if turns == 1:
		cam.position_smoothing_speed = defaultCamSpeed
		$shakeCD.stop()
		position = Vector2.ZERO

func timestop():
	t = 2
	Engine.time_scale = 0
	get_parent().get_parent().frozen=true
	$timeCD.start()
	
	
	
