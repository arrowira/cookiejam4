extends Control

var inSlow = false
var slowLength = 0

@onready var hand = $watchCenter
func startTime(length):
	if !inSlow:
		$"../../music".slow()
		$"../../audio/timeSlow".play()
		$vigFade.play("in")
		inSlow = true
		slowLength = length
		Engine.time_scale = 0.3
		t = length
		

var t = 0
func _physics_process(delta: float) -> void:
	if t!=0:
		t -= 1/50.0
		hand.rotation_degrees += 360/(50.0*slowLength)
	if t < 0:
		#end timeslow
		$"../../music".normal()
		$"../../audio/timeSlow".stop()
		$vigFade.play("out")
		hand.rotation_degrees = 0
		inSlow=false
		Engine.time_scale = 1
		t=0
