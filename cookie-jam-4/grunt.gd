extends RigidBody2D

var player = Vector2.RIGHT
var health = 100
var towardsPlayer = Vector2.RIGHT
var inKB = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	player = get_parent().get_parent().get_node("player").anchorPos
	

func _physics_process(delta: float) -> void:
	rotation = 0
	if !inKB:
		towardsPlayer = (player-global_position).normalized()
		position+=towardsPlayer
	
	
	
func damage(amt):
	var kbVector = (300*amt) * (-towardsPlayer).normalized()
	apply_central_impulse(kbVector)
	health-=amt
	
	inKB = true
	$knockback.start()


func _on_knockback_timeout() -> void:
	inKB = false
