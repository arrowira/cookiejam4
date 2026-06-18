extends Control


func initialize():
	pass

func _on_panel_mouse_entered() -> void:
	position.y -= 30


func _on_panel_mouse_exited() -> void:
	position.y += 30
