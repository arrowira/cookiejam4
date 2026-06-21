extends Node2D

var anchor = "red"
var bSpinSpeed = 5
var rSpinSpeed = 5
var anchorPos = Vector2.ZERO
var upgradeID = 0

var redHealth = 3
var blueHealth = 3
var redDamageMod = 1
var blueDamageMod = 1

var frozen = false

var upgrades = [0,0,0,0,0,0,0]
var timeSlowLength = 1.0
var dead=false
var latestPickUp
var xp = 0
var maxXP = 100
var lvl = 0
var lastEnemy
var pBanana = preload("res://scenes/pick_up.tscn")

@onready var red = $bSpin/red
@onready var blue = $rSpin/blue
@onready var circle = $SpeedCircle
@onready var audio = $audio

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Line2D.add_point(Vector2.ZERO,0)
	$Line2D.add_point(Vector2.ZERO,1)
	for i in range(3):
		$hud/redHearts.addHeart("red")
		$hud/blueHearts.addHeart("blue")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !dead:
		$Line2D.set_point_position(0, blue.global_position)
		$Line2D.set_point_position(1, red.global_position)
	
	anchorPos = $"camera anchor".position
	
	if Input.is_action_just_pressed("k"):
		changeRope(-20)
	
	if Input.is_action_just_pressed("x"):
		$hud/stopwatch.startTime(timeSlowLength)
	
	if Input.is_action_just_pressed("space") and !dead:
		audio.anchor()
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

func upgrade(pickup):
	latestPickUp=pickup
	frozen = true
	Engine.time_scale = 0.1
	$hud/upgradeMenu/Panel/upgradeCard.initialize()
	$hud/upgradeMenu/Panel/upgradeCard2.initialize()
	$hud/upgradeMenu.visible = true


#id keys:
#1 = red health up
#2 = blue health up
#3 = +0.5 sec time slow
#4 = +speed from speed ring
#5 = +rope length
func upgradePart2():
	latestPickUp.consume()
	upgrades[upgradeID-1]+=1
	if upgradeID == 1:
		#up red health
		$hud/redHearts.addHeart("red")
	elif upgradeID == 2:
		#up blue health
		$hud/blueHearts.addHeart("blue")
	elif upgradeID == 3:
		$hud/stopwatch.visible=true
		timeSlowLength+=0.5
	elif upgradeID == 4:
		$SpeedCircle.visible=true
		circle.winBoost += 0.3
	elif upgradeID == 5:
		changeRope(100)
	elif upgradeID == 6:
		redDamageMod += 0.2
	elif upgradeID == 7:
		redDamageMod += 0.2
		

func _physics_process(delta: float) -> void:
	blue.animSpeed = bSpinSpeed/12.0
	red.animSpeed = rSpinSpeed/12.0
	if dead:
		Engine.time_scale = $deathTimer.time_left
		if $deathTimer.time_left < 0.5:
			$hud/deathMenu.visible = true
	
	if !frozen:
		if anchor == "red":
			if !dead:
				if int($rSpin.rotation_degrees+20)%360 <5+rSpinSpeed:
					audio.swoosh()
				$rSpin.rotation_degrees += rSpinSpeed*Engine.time_scale
			else:
				$rSpin.position += (8.0*rSpinSpeed)*Vector2(cos($rSpin.rotation + PI/2),sin($rSpin.rotation + PI/2))
		else:
			if !dead:
				if int($bSpin.rotation_degrees+200)%360 <5+rSpinSpeed:
					audio.swoosh()
				$bSpin.rotation_degrees += bSpinSpeed*Engine.time_scale
			else:
				$bSpin.position += (8.0*bSpinSpeed)*Vector2(cos($bSpin.rotation - PI/2),sin($bSpin.rotation - PI/2))

func death():
	print("dead")
	
	$music.slow()
	$deathTimer.start()
	circle.queue_free()
	if anchor == "red":
		$bSpin/red.die()
	else:
		$rSpin/blue.die()
	dead=true
	
func addXP():
	$audio.xp()
	xp+=6
	$hud/xpBar.value=xp
	
	if xp%maxXP != xp:
		#level up
		$audio/lvlUp.play()
		var banana = pBanana.instantiate()
		banana.global_position = lastEnemy
		get_parent().add_child(banana)
		lvl+=1
		$hud/xpBar/text.text = "level " + str(lvl)
		xp = xp%maxXP
		maxXP+=10
		$hud/xpBar.max_value = maxXP

func hurt(color, amt):
	if !dead:
		$"camera anchor/shaker".shake(6,100)
		for i in range(amt):
			if color == "red":
				$hud/redHearts.takeDamage()
				redHealth-=1
			else:
				$hud/blueHearts.takeDamage()
				blueHealth-=1

func hit(color, body):
	
	if body.dead == false:
		audio.hit()
		
		var damageX = 2*((rSpinSpeed+bSpinSpeed)/10)
		if color == "red":
			damageX *= redDamageMod
		else:
			damageX *= blueDamageMod
		changeSpinSpeed(-0.1)
		if color == "red":
			body.damage(15*damageX)
		elif color == "blue":
			body.damage(15*damageX)
			
		if body.dead:
			lastEnemy = body.global_position
		
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
	


func _on_enter_b_button_down() -> void:
	frozen = false
	Engine.time_scale=1
	upgradePart2()
	$hud/upgradeMenu.visible=false
