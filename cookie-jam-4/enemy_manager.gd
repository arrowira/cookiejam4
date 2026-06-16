extends Node2D

var pGrunt = preload("res://scenes/grunt.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_cd_timeout() -> void:
	var grunt = pGrunt.instantiate()
	grunt.global_position.x = randf_range(-10,10)
	grunt.global_position.y = randf_range(-10,10)
	add_child(grunt)
