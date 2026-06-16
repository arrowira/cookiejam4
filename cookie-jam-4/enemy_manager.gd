extends Node2D

var pGrunt = preload("res://scenes/grunt.tscn")

var population = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_cd_timeout() -> void:
	var fate = randi_range(1,2)
	
	if fate == 1:
		population+=1
		var grunt = pGrunt.instantiate()
		grunt.global_position.x = randf_range(-1000,1000)
		grunt.global_position.y = randf_range(-1000,1000)
		add_child(grunt)
