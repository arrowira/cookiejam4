extends Panel


var hearts = []
var pRHeart = preload("res://scenes/red_heart.tscn")
var pBHeart = preload("res://scenes/blue_heart.tscn")
var health = 0

func addHeart(color):
	var heart
	if color == "red":
		heart = pRHeart.instantiate()
	else:
		heart = pBHeart.instantiate()
	heart.position = Vector2(len(hearts)*50 + 40, position.y+10)
	hearts.append(heart)
	heal()
	add_child(heart)
	
func takeDamage():
	health -= 1
	flipHeart(health,1)
func heal():
	health += 1
	flipHeart(health-1,0)

func flipHeart(index, bit):
	hearts[index].frame = bit

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		addHeart("red")
	if Input.is_action_just_pressed("k"):
		takeDamage()
	if Input.is_action_just_pressed("i"):
		heal()
