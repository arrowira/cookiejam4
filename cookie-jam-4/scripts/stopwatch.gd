extends Control


func startTime(length):
	Engine.time_scale = 0.3
	t = length
	

var t = 0
func _physics_process(delta: float) -> void:
	if t!=0:
		t -= 1/50.0
	if t < 0:
		print("end time")
		#end timeslow
		Engine.time_scale = 1
		t=0
