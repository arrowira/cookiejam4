extends RigidBody2D

var player = Vector2.RIGHT
var health = 100
var towardsPlayer = Vector2.RIGHT
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damage(30)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player = get_parent().get_node("player").anchorPos
	

func _physics_process(delta: float) -> void:
	towardsPlayer = (player-global_position).normalized()
	position+=towardsPlayer
	
	
	
func damage(amt):
	
	var kbVector = (10*amt) * (-towardsPlayer).normalized()
	apply_central_impulse(kbVector)
	health-=amt
