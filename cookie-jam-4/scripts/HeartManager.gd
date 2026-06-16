extends Panel


var hearts = []
var pRHeart = preload("res://scenes/red_heart.tscn")
var pBHeart = preload("res://scenes/blue_heart.tscn")

func addHeart(color):
	var heart
	if color == "red":
		heart = pRHeart.instantiate()
	else:
		heart = pBHeart.instantiate()
	heart.position = Vector2(len(hearts)*50 + 40, position.y+10)
	hearts.append(heart)
	add_child(heart)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		addHeart("red")
