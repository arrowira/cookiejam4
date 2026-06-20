extends Node2D

var pGrunt = preload("res://scenes/grunt.tscn")
var pNecro = preload("res://scenes/necromancer.tscn")
var playerPos 
var distance = 1500

var population = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	playerPos = get_parent().get_node("player").anchorPos

func _on_spawn_cd_timeout() -> void:
	var fate = randi_range(1,5)
	var angle = randf_range(0,2*PI)
	
	if fate == 1:
		population+=1
		var necro = pNecro.instantiate()
		necro.global_position = playerPos+distance*Vector2(cos(angle),sin(angle))
		add_child(necro)
