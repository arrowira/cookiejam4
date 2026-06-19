extends Control


func startTime(length):
	Engine.time_scale = 0.5
	t = length

var t = -1
func _physics_process(delta: float) -> void:
	t - 1/50.0
	if t == 0:
		#end timeslow
		Engine.time_scale = 1
		t-=1
