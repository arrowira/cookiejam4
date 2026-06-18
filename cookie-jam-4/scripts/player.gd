extends Node2D

var anchor = "red"
var bSpinSpeed = 5
var rSpinSpeed = 5
var anchorPos

var redHealth = 3
var blueHealth = 3

@onready var red = $bSpin/red
@onready var blue = $rSpin/blue
@onready var circle = $SpeedCircle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Line2D.add_point(Vector2.ZERO,0)
	$Line2D.add_point(Vector2.ZERO,1)
	for i in range(3):
		$hud/redHearts.addHeart("red")
		$hud/blueHearts.addHeart("blue")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Line2D.set_point_position(0, blue.global_position)
	$Line2D.set_point_position(1, red.global_position)
	anchorPos = $"camera anchor".position
	
	if Input.is_action_just_pressed("k"):
		changeRope(-20)
		
	
	if Input.is_action_just_pressed("space"):
		changeSpinSpeed(-0.3 )
		if anchor == "red":
			circle.global_position = blue.global_position
			anchor = "blue"
			blue.anchor()
			red.deanchor()
			$bSpin.rotation_degrees = $rSpin.rotation_degrees
			$bSpin.global_position = blue.global_position
			$"camera anchor".global_position = blue.global_position
		else:
			circle.global_position = red.global_position
			blue.deanchor()
			red.anchor()
			anchor = "red"
			$rSpin.rotation_degrees = $bSpin.rotation_degrees
			$rSpin.global_position = red.global_position
			$"camera anchor".global_position = red.global_position
			
func _physics_process(delta: float) -> void:
	if anchor == "red":
		$rSpin.rotation_degrees += rSpinSpeed
	else:
		$bSpin.rotation_degrees += bSpinSpeed

func hurt(color, amt):
	$"camera anchor/shaker".shake(6,100)
	for i in range(amt):
		if color == "red":
			$hud/redHearts.takeDamage()
			redHealth-=1
		else:
			$hud/blueHearts.takeDamage()
			blueHealth-=1

func hit(color, body):
	var damageX = 2*((rSpinSpeed+bSpinSpeed)/10)
	changeSpinSpeed(-0.1)
	if color == "red":
		body.damage(15*damageX)
	elif color == "blue":
		body.damage(15*damageX)
		
func changeRope(dLength):
	blue.position.x += dLength
	red.position.x -= dLength

func changeBlueSpinSpeed(amt):
	bSpinSpeed+=amt
func changeRedSpinSpeed(amt):
	rSpinSpeed+=amt
func changeSpinSpeed(amt):
	if amt < 0:
		if rSpinSpeed > 4 and bSpinSpeed > 4:
			changeBlueSpinSpeed(amt)
			changeRedSpinSpeed(amt)
	else:
		changeBlueSpinSpeed(amt)
		changeRedSpinSpeed(amt)
	
