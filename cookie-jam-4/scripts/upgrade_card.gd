extends Control


var mouseIn = false

var id = 0

func initialize():
	id = randi_range(1,5)
	$Panel2/Panel/BodyText.text = str(id)
func _process(delta: float) -> void:
	var t = get_global_mouse_position()
	$Panel2.get_material().set_shader_parameter("focusPoint", t)
	
	if mouseIn and Input.is_action_just_pressed("click"):
		#select this card
		get_parent().get_parent().get_parent().get_parent().upgradePart2(id)


func _on_panel_mouse_entered() -> void:
	position.y -= 10
	mouseIn = true


func _on_panel_mouse_exited() -> void:
	position.y += 10
	mouseIn = false
