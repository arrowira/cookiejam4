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
	heart.position = Vector2(len(hearts)*50 + 40, 21)
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
