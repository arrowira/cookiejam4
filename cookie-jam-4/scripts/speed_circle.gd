extends Node2D

@onready var c = $expander/center

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("space"):
		$AnimationPlayer.play("RESET")
		$AnimationPlayer.play("fadeIn")
	
	c.rotation_degrees += 5
	c.rotation_degrees = int(c.rotation_degrees)%360
	
	if Input.is_action_just_pressed("c"):
		
		if c.rotation_degrees > 350 or c.rotation_degrees < 10:
			$expander.scale *= 1.2
			get_parent().changeSpinSpeed(2)
	
	if $expander.scale.length() >= 1.5:
		$expander.scale *= 0.99
