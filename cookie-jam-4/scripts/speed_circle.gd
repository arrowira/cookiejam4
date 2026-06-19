extends Node2D

@onready var c = $expander/center

var winBoost = 1

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("space"):
		$AnimationPlayer.play("RESET")
		$AnimationPlayer.play("fadeIn")
	
	c.rotation_degrees += 5
	c.rotation_degrees = int(c.rotation_degrees)%360
	
	if Input.is_action_just_pressed("c"):
		
		#successes:
		if c.rotation_degrees > 350 or c.rotation_degrees < 20:
			$expander.scale *= 1.2
			get_parent().changeSpinSpeed(winBoost)
	
	if $expander.scale.length() >= 1.5:
		$expander.scale *= 0.99
