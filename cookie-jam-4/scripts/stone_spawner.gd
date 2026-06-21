extends Node2D
var res = Vector2(40000,20000)
var pStone = preload("res://scenes/tombstone.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(700):
		var stone = pStone.instantiate()
		stone.position = Vector2(randi_range(-res.x/2, res.x/2),randi_range(-res.y/2,res.y/2))
		add_child(stone)
