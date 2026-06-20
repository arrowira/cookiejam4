extends RigidBody2D

var player = Vector2.RIGHT
var health = 100
var towardsPlayer = Vector2.RIGHT
var inKB = false
var frozen = false
var dead = false

var pGhost = preload("res://scenes/grunt_ghost.tscn")
var speed = 0.5

var t = 0
var isWalking = true
var isCasting = false
var orbIn = false

func _ready() -> void:
	$healthBar.value = 100
	
	$Icon.modulate.b -= randf()/3.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !frozen:
		if isWalking:
			$AnimationPlayer.play("walk")
			if player.x<global_position.x:
				$Icon.flip_h=false
				$Icon/shadow.position = Vector2(0.8,16.3)
			else:
				$Icon.flip_h=true
				$Icon/shadow.position = Vector2(-0.8,16.3)
		else:
			if !isCasting:
				$AnimationPlayer.play("RESET")
		
		player = get_parent().get_parent().get_node("player").anchorPos
	

func _physics_process(delta: float) -> void:
	t+=0.01
	rotation = 0
	if !inKB and !frozen and isWalking:
		towardsPlayer = (player-global_position).normalized()
		position+=towardsPlayer*speed*Engine.time_scale + (1.0)*Vector2(cos(t),sin(t))


func cast():
	isCasting=true
	$castTime.start()
	$AnimationPlayer.play("cast")

func death():
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
	if !isWalking and randf() < 0.3:
		cast()


func _on_cast_time_timeout() -> void:
	isCasting = false
