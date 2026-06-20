extends Node2D

@export var weapon = false
@export var color = "red"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$shadowswivel.global_rotation_degrees = 0.0
	
	if !weapon:
		global_rotation_degrees = 0
	else:
		if color == "red":
			rotation = -PI/2
		else:
			rotation = PI/2

func die():
	$AnimationPlayer.play("death")
func anchor():
	weapon = false
	$AnimationPlayer.play("anchored")
func deanchor():
	weapon = true
	$AnimationPlayer.play("unanchored")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_node("grunt") != null or body.get_node("riffler") != null:
		if weapon:
			get_parent().get_parent().hit(color, body)
		else:
			get_parent().get_parent().hurt(color, 1)
			body.knockback(30)
	elif body.get_node("stone") != null:
		body.get_parent()._break()
		#get_parent().get_parent().get_node("camera anchor").get_node("shaker").shake(3,10)
