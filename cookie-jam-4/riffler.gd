extends RigidBody2D

var player = Vector2.RIGHT
var health = 100
var towardsPlayer = Vector2.RIGHT
var inKB = false
var speed = 5

var dir = Vector2.ZERO
var behaviour = "d"

func _ready() -> void:
	$healthBar.value = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	player = get_parent().get_parent().get_node("player").anchorPos
	

func _physics_process(delta: float) -> void:
	rotation = 0
	towardsPlayer = (player-global_position).normalized()
	if !inKB and behaviour == "running":
		print("rn")
		position+=dir*speed

func death():
	queue_free()
	
	
func damage(amt):
	var kbVector = (300*amt) * (-towardsPlayer).normalized()
	apply_central_impulse(kbVector)
	health-=amt

	
	if health <= 0:
		health = 0
		death()
	
	inKB = true
	$healthBar.value = health
	$knockback.start()


func _on_knockback_timeout() -> void:
	inKB = false


func _on_behaviour_cd_timeout() -> void:
	dir = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	if randf()<0.5:
		behaviour = "running"
	else:
		behaviour = "stationary"


func _on_shooting_cd_timeout() -> void:
	pass # Replace with function body.
