extends RigidBody2D

var player = Vector2.RIGHT
var health = 100
var towardsPlayer = Vector2.RIGHT
var inKB = false
var frozen = false
var dead = false

var pGhost = preload("res://scenes/grunt_ghost.tscn")
var pGrunt = preload("res://scenes/grunt.tscn")
var speed = 0.6
var t = 0

var abilityCD = false

func spawnMinions():
	var num = randi_range(2,6)
	for i in range(num):	
		var distance = randf_range(200, 600)
		var angle = randf_range(0,7)
		var grunt = pGrunt.instantiate()
		grunt.global_position = Vector2(global_position.x+cos(angle)*distance,global_position.y+sin(angle)*distance)
		get_parent().add_child(grunt)
	

func _ready() -> void:
	$healthBar.value = 100
	
	$Icon.modulate.b -= randf()/3.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("i"):
		spawnMinions()
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
	t+=0.02
	rotation = 0
	if !inKB and !frozen:
		towardsPlayer = (player-global_position).normalized()
		position+=towardsPlayer*speed*Engine.time_scale + Vector2(cos(t), sin(t))

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


func _on_ability_timeout() -> void:
	if randf()<0.1 and !abilityCD:
		abilityCD = true
		$abCD.start()
		spawnMinions()


func _on_ab_cd_timeout() -> void:
	abilityCD = false
