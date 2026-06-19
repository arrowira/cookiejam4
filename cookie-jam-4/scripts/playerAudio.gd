extends Node2D

func hit():
	$hit.pitch_scale = 1.5 + randf_range(-0.2,0.2)
	$hit.play()
func anchor():
	$plant.play()
	
