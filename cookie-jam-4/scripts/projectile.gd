extends Area2D

var speed = 0
var targetSpeed = 1.5
var dying = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("spawn")

var t = 0
func _physics_process(delta: float) -> void:
	t+=0.1
	position += speed*Vector2(-cos(rotation), -sin(rotation))*Engine.time_scale
	
	#friction
	speed = (targetSpeed*t+1)/(t+3)*10
	$Circle256.global_rotation = 0
	if $death.time_left <= 0.5 and !dying:
		dying = true
		$AnimationPlayer.play("death")
	


func _on_death_timeout() -> void:
	queue_free()
