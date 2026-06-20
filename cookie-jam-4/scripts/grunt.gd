extends RigidBody2D

var player = Vector2.RIGHT
var health = 100
var towardsPlayer = Vector2.RIGHT
var inKB = false
var frozen = false
var dead = false

var pGhost = preload("res://scenes/grunt_ghost.tscn")
var speed = 1.5
var pXP = preload("res://scenes/xp_dot.tscn")


func _ready() -> void:
	frozen=true
	$spawnin.start()
	$healthBar.value = 100
	
	$Icon.modulate.b -= randf()/3.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !frozen:
		$AnimationPlayer.play("walk")
		if player.x<global_position.x:
			$Icon.flip_h=false
			$Icon/shadow.position = Vector2(0.8,7.8)
		else:
			$Icon.flip_h=true
			$Icon/shadow.position = Vector2(-0.8,7.8)
		
		player = get_parent().get_parent().get_node("player").anchorPos
	

func _physics_process(delta: float) -> void:
	z_index = global_position.y/100.0
	rotation = 0
	if !inKB and !frozen:
		towardsPlayer = (player-global_position).normalized()
		position+=towardsPlayer*speed*Engine.time_scale

func death():
	#spawnXP
	for i in range(randi_range(1,3)):
		var xp = pXP.instantiate()
		xp.global_position = global_position
		xp.position.x += randf()*50 - 25
		xp.position.y += randf()*50 - 25
		get_parent().get_parent().add_child(xp)
	
	
	$CollisionShape2D.queue_free()
	dead = true
	frozen = true
	var ghost = pGhost.instantiate()
	ghost.global_position=global_position
	get_parent().add_child(ghost)
	
	$deathTimer.start()
	$AnimationPlayer.play("die")
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


func _on_spawnin_timeout() -> void:
	frozen=false
