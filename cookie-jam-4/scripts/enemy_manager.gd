extends Node2D

var pGrunt = preload("res://scenes/grunt.tscn")
var pNecro = preload("res://scenes/necromancer.tscn")

var population = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_cd_timeout() -> void:
	var fate = randi_range(1,5)
	
	if fate == 1:
		population+=1
		var necro = pNecro.instantiate()
		necro.global_position.x = randf_range(-1000,1000)
		necro.global_position.y = randf_range(-1000,1000)
		add_child(necro)
