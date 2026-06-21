extends Node2D

@onready var c = $expander/center

var winBoost = 0.5
var inCD = false

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("space"):
		$AnimationPlayer.play("RESET")
		$AnimationPlayer.play("fadeIn")
	
	c.rotation_degrees += 5
	c.rotation_degrees = int(c.rotation_degrees)%360
	
	if Input.is_action_just_pressed("c") and !inCD:
		
		#successes:
		if c.rotation_degrees > 350 or c.rotation_degrees < 20:
			$speed.play()
			$expander.scale *= 1.2
			get_parent().changeSpinSpeed(winBoost)
		else:
			$CD.start()
			$err.play()
			get_parent().changeSpinSpeed(-0.5)
			inCD = true
			modulate.r = 1
			modulate.g = 0.3
			modulate.b = 0.3
	
	if $expander.scale.length() >= 1.5:
		$expander.scale *= 0.99


func _on_cd_timeout() -> void:
	inCD = false
	modulate.r = 1
	modulate.g = 1
	modulate.b = 1
