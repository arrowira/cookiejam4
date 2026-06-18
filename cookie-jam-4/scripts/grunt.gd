extends RigidBody2D

var player = Vector2.RIGHT
var health = 100
var towardsPlayer = Vector2.RIGHT
var inKB = false

func _ready() -> void:
	$healthBar.value = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AnimationPlayer.play("walk")
	if player.x<global_position.x:
		$Icon.flip_h=false
	else:
		$Icon.flip_h=true
	
	player = get_parent().get_parent().get_node("player").anchorPos
	

func _physics_process(delta: float) -> void:
	rotation = 0
	if !inKB:
		towardsPlayer = (player-global_position).normalized()
		position+=towardsPlayer

func death():
	queue_free()
	
	
func damage(amt):
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
