extends Control


var mouseIn = false

var id = 0
var player

func _ready() -> void:
	player = get_parent().get_parent().get_parent().get_parent()

func initialize():
	id = randi_range(1,5)
	#id keys:
	#1 = red health up
	#2 = blue health up
	#3 = +0.5 sec time slow
	#4 = +speed from speed ring
	#5 = +rope length
	
	#new ability! check
	var new = false
	if id == 3:
		if player.upgrades[id-1] == 0:
			$Panel2/Panel/NewUpgrade.visible = true
			new = true
			
			
			
		else:
			$Panel2/Panel/NewUpgrade.visible = false
	else:
		$Panel2/Panel/NewUpgrade.visible = false
		
	#ability description text
	var bodyText = ""
	match id:
		1:
			bodyText = "add one heart to red's health"
		2:
			bodyText = "add one heart to blue's health"
		3:
			if new:
				bodyText = "when you press x, slow down time for 0.5 seconds"
			else:
				bodyText = "add 0.5 seconds to time slow"
		4:
			bodyText = "gain more speed from a successful speed ring hit"
		5:
			bodyText = "Increase your rope length by ~6cm"
	$Panel2/Panel/BodyText.text = bodyText
	
func _process(delta: float) -> void:
	var t = get_global_mouse_position()
	$Panel2.get_material().set_shader_parameter("focusPoint", t)
	
	if mouseIn and Input.is_action_just_pressed("click"):
		#select this card
		$highlight.visible = true
		player.upgradeID = id
	elif Input.is_action_just_pressed("click"):
		$highlight.visible = false


func _on_panel_mouse_entered() -> void:
	position.y -= 10
	mouseIn = true


func _on_panel_mouse_exited() -> void:
	position.y += 10
	mouseIn = false
