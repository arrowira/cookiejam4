extends Area2D

var speed = 0
var targetSpeed = 3.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("spawn")

var t = 0
func _physics_process(delta: float) -> void:
	t+=0.1
	position += speed*Vector2(-cos(rotation), -sin(rotation))*Engine.time_scale
	
	#friction
	speed = (targetSpeed*t+1)/(t+3)*10
	


func _on_death_timeout() -> void:
	queue_free()
