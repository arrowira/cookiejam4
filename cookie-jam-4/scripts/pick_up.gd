extends Node2D

var red = false
var blue = false

var dying = false
var t = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("spin")
	$Icon.frame=0


func open():
	if !dying:
		get_parent().get_node("player").upgrade(self)
		$Icon.frame=7
		dying = true
func consume():
	$AnimationPlayer.play("consume")
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("e"):
		if red or blue:
			open()
func _physics_process(delta: float) -> void:
	t+=0.01
	if !dying:
		var towardsPlayer = get_parent().get_node("player").anchorPos - global_position
		position += towardsPlayer.normalized()*2*t*Engine.time_scale


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "red":
		red = true
	if area.get_parent().name == "blue":
		blue = true




func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().name == "red":
		red = false
	if area.get_parent().name == "blue":
		blue = false


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "red":
		open()
	if area.get_parent().name == "blue":
		open()


func _on_timer_timeout() -> void:
	queue_free()
