extends Node2D

func slow():
	$AudioStreamPlayer.pitch_scale = 0.3
	
func normal():
	$AudioStreamPlayer.pitch_scale = 1.0
