extends Node2D


func setting():
	pass
func howTo():
	pass
func play():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_start_b_button_down() -> void:
	$cameraAnchor.position.y -= 3000
	$startTimer.start()


func _on_settings_b_button_down() -> void:
	$cameraAnchor.global_position=$settingsAnchor.global_position


func _on_how_to_b_button_down() -> void:
	$cameraAnchor.global_position=$howToAnchor.global_position

func _on_start_timer_timeout() -> void:
	play()

func back():
	$cameraAnchor.global_position = Vector2.ZERO
