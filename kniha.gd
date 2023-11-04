extends Node2D

var strany
var strana_teraz = 0
var bezi_animacia = false
var animacia_strany
var animacia_kam
# Called when the node enters the scene tree for the first time.
func _ready():
	$vsetko.visible = false
	strany = []
	var i = 0
	for child in $vsetko.get_children():
		if child.is_in_group("strana"):
			strany.push_back(child)
			child.visible = false
			if i == 0 or i == len(strany) - 2:
				child.get_node("papier").get_node("cislo").text = ""
			else:
				child.get_node("papier").get_node("cislo").text = str(i)

			if i % 2 == 1:
				#child.position.x = 600
				child.get_node("papier").position.y = -child.get_node("papier").position.y
			i += 1

	strany[strana_teraz].visible = true
	strany[strana_teraz+1].visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var v = 2
	if bezi_animacia:
		if animacia_kam == 1:
			#print(rad_to_deg(animacia_strany[0].skew),animacia_strany[0].visible)
			if animacia_strany[0].skew > deg_to_rad(-90):
				animacia_strany[0].skew -= delta*v
			else:
				animacia_strany[0].visible = false
				if animacia_strany[1].skew > deg_to_rad(0):
					animacia_strany[1].skew -= delta*v
				else:
					animacia_strany[1].visible = false
					for i in $vsetko/animacia.get_children():
						$vsetko/animacia.remove_child(i)
					bezi_animacia = false
		if animacia_kam == -1:
			if animacia_strany[0].skew < deg_to_rad(90):
				animacia_strany[0].skew += delta*v
			else:
				animacia_strany[0].visible = false
				if animacia_strany[1].skew < deg_to_rad(0):
					animacia_strany[1].skew += delta*v
				else:
					animacia_strany[1].visible = false
					for i in $vsetko/animacia.get_children():
						$vsetko/animacia.remove_child(i)
					bezi_animacia = false
		if bezi_animacia == false:
			$vsetko/doprava.disabled = false
			$vsetko/dolava.disabled = false
			
			strany[strana_teraz-2*animacia_kam].visible = false
			strany[strana_teraz-2*animacia_kam+1].visible = false
			

			strany[strana_teraz].visible = true
			strany[strana_teraz+1].visible = true

func duplikovat_stranu(strana):
	var nova = strana.duplicate()
	nova.get_node("papier").position.y = strana.get_node("papier").position.y
	nova.get_node("papier").get_node("cislo").text = strana.get_node("papier").get_node("cislo").text
	return nova


func otocit(kam):#1 - dopredu, strana sa toci dolava  -1 dozadu, strana sa toci doprava
	bezi_animacia = true
	animacia_kam = kam
	$vsetko/doprava.disabled = true
	$vsetko/dolava.disabled = true
	if kam == 1:
		animacia_strany = [duplikovat_stranu(strany[strana_teraz+1]),duplikovat_stranu(strany[strana_teraz+2])]
		animacia_strany[1].skew = deg_to_rad(90)
	if kam == -1:
		animacia_strany = [duplikovat_stranu(strany[strana_teraz]),duplikovat_stranu(strany[strana_teraz-1])]
		animacia_strany[1].skew = deg_to_rad(-90)
	for i in animacia_strany:
		i.z_index = 1
		i.visible = true
		$vsetko/animacia.add_child(i)
	
	if kam != 1:
		strany[strana_teraz].visible = false
	if kam != -1:
		strany[strana_teraz+1].visible = false
	strana_teraz += kam*2
	
#	if strana_teraz != 0:
	if kam != 1:
		strany[strana_teraz].visible = true
#	if strana_teraz+1 != len(strany)-1:
	if kam != -1:
		strany[strana_teraz+1].visible = true


func _on_doprava_button_down():
	if strana_teraz <= len(strany)-4:
		otocit(1)

func _on_dolava_button_down():
	if strana_teraz >= 2:
		otocit(-1)


func _on_toggle_toggled(button_pressed):
	$vsetko.visible = button_pressed
	global.mas_otvorene_noviny = $vsetko.visible
