extends Node2D

var t = 500.0
var maxT = 500.0

var ghostShader = preload("res://ghost.gdshader")

func _ready() -> void:
	#maxT = t
	#var newMaterial = ShaderMaterial.new()
	#newMaterial.shader = ghostShader
	#var texture = load("res://sprites/Zombie_Monkey_Sprite_Sheet.webp")
	#newMaterial.set_shader_parameter("Tex", texture)
	#$Icon.material = newMaterial
	
	pass

func _physics_process(delta: float) -> void:
	$Icon.get_material().set_shader_parameter("alpha", 1)
	
	position.y-=5
	t-=1
	if t == 0:
		queue_free()
