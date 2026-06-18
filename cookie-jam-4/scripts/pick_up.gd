extends Node2D

var red = false
var blue = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("e"):
		if red or blue:
			queue_free()


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
	pass # Replace with function body.
