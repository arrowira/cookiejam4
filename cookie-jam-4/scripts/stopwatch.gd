extends Control

var inSlow = false
var slowLength = 0
var inCD = false

@onready var hand = $watchCenter
func startTime(length):
	if !inSlow and !inCD:
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
		$CD.start()
		$"../../music".normal()
		$"../../audio/timeSlow".stop()
		$vigFade.play("out")
		inCD = true
		modulate.a = 0.3
		hand.rotation_degrees = 0
		inSlow=false
		Engine.time_scale = 1
		t=0


func _on_cd_timeout() -> void:
	inCD=false
	modulate.a = 1
