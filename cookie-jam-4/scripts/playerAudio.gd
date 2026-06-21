extends Node2D

func hit():
	$hit.pitch_scale = 1 + randf_range(-0.2,0.2)
	$hit.play()
func anchor():
	$plant.play()
func swoosh():
	$swoosh.play()
func speed():
	$speed.play()
func xp():
	$sound.pitch_scale = 1.3 + randf()/5.0
	$sound.play()
func orb():
	$orb.pitch_scale= 0.9 + randf()/5.0
	$orb.play()
func damage():
	$damage.play()
