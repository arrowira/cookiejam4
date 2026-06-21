extends Node2D


func _process(delta: float) -> void:
	# Get the index of the Master bus
	var master_bus_idx = AudioServer.get_bus_index("Master")

	AudioServer.set_bus_volume_db(master_bus_idx, linear_to_db($Panel/HSlider.value/100.0))
