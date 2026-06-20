extends RigidBody2D

var player = Vector2.RIGHT
var health = 100
var towardsPlayer = Vector2.RIGHT
var inKB = false
var frozen = false
var dead = false

var pGhost = preload("res://scenes/grunt_ghost.tscn")
var pXP = preload("res://scenes/xp_dot.tscn")
var speed = 0.5

var t = 0
var isWalking = true
var isCasting = false
var orbIn = false
var pOrb = preload("res://scenes/projectile.tscn")

func _ready() -> void:
	$healthBar.value = 100
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if !frozen and !dead:
		if isCasting and !orbIn:
			if $castTime.time_left < 0.5:
				orbIn = true
				var orb = pOrb.instantiate()
				orb.global_position = $Icon/orbSpot.global_position
				orb.rotation = atan2($Icon/orbSpot.global_position.y-player.y, $Icon/orbSpot.global_position.x-player.x)
				get_parent().get_parent().add_child(orb)
		
		if isWalking:
			$AnimationPlayer.play("walk")
			if player.x<global_position.x:
				$Icon.flip_h=false
				$Icon/shadow.position = Vector2(0.8,16.3)
				$Icon/orbSpot.position.x = -19.4
			else:
				$Icon/orbSpot.position.x = 19.4
				$Icon.flip_h=true
				$Icon/shadow.position = Vector2(-0.8,16.3)
		else:
			if !isCasting:
				$AnimationPlayer.play("RESET")
		
		player = get_parent().get_parent().get_node("player").anchorPos
	

func _physics_process(delta: float) -> void:
	z_index = global_position.y/100.0
	
	t+=0.01
	rotation = 0
	towardsPlayer = (player-global_position).normalized()
	if !inKB and !frozen and isWalking:
		position+=towardsPlayer*speed*Engine.time_scale + (1.0)*Vector2(cos(t),sin(t))


func cast():
	isCasting=true
	$castSFX.play()
	$castTime.start()
	$AnimationPlayer.play("cast")

func death():
	get_parent().wizards-=1
	$deathSFX.play()
	
	#spawnXP
	for i in range(6):
		var xp = pXP.instantiate()
		xp.global_position = global_position
		xp.position.x += randf()*200 - 100
		xp.position.y += randf()*200 - 100
		get_parent().get_parent().add_child(xp)
	
	dead = true
	frozen = true
	var ghost = pGhost.instantiate()
	ghost.global_position=global_position
	get_parent().add_child(ghost)
	
	$deathTimer.start()
	$AnimationPlayer.play("death")
	$healthBar.visible = false
	
	
func damage(amt):
	if !dead:
		health-=amt
		knockback(amt)
		
		if health <= 0:
			health = 0
			death()
		
		$healthBar.value = health
		
	
func knockback(intensity):
	var kbVector = (300*intensity) * (-towardsPlayer).normalized()
	apply_central_impulse(kbVector)
	inKB = true
	$knockback.start()


func _on_knockback_timeout() -> void:
	inKB = false


func _on_death_timer_timeout() -> void:
	queue_free()


func _on_behavior_timeout() -> void:
	if randf() < 0.3:
		isWalking=false
	else:
		if !isCasting:
			isWalking=true
	if !isWalking and randf() < 0.5 and !isCasting and !dead:
		cast()


func _on_cast_time_timeout() -> void:
	isCasting = false
	orbIn = false
