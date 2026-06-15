extends Node2D

var anchor = "red"
var bSpinSpeed = 1
var rSpinSpeed = 1
@onready var red = $bSpin/red
@onready var blue = $rSpin/blue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		if anchor == "red":
			anchor = "blue"
			$bSpin.rotation_degrees = $rSpin.rotation_degrees
			$bSpin.global_position = blue.global_position
		else:
			anchor = "red"
			$rSpin.rotation_degrees = $bSpin.rotation_degrees
			$rSpin.global_position = red.global_position
			
func _physics_process(delta: float) -> void:
	if anchor == "red":
		$rSpin.rotation_degrees += rSpinSpeed
	else:
		$bSpin.rotation_degrees += bSpinSpeed
		
		
