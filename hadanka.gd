extends Node2D

signal odpoved()
# Called when the node enters the scene tree for the first time.
var vysledok
var zablokovane = false
var cas_zablokovania
var zablokovanie_timeout = 15
func _ready():
	pass

func nastav_texty(moznosti):
	$otazka.text = moznosti[0]
	$Button1/moznost1.text = moznosti[1]
	$Button2/moznost2.text = moznosti[2]
	$Button3/moznost3.text = moznosti[3]
	$Button4/moznost4.text = moznosti[4]
	vysledok = moznosti[5]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(zablokovane)
	if zablokovane:
		cas_zablokovania += delta
		$nespravne.text = "neuhadol si, nemozes hadat najblizsich " + str(int(zablokovanie_timeout-cas_zablokovania)) + " sekund"
		if cas_zablokovania >= zablokovanie_timeout:#
			zablokovane = false
			$nespravne.text = ""

func _on_button_1_button_down():
	odpovedal(1)

func _on_button_2_button_down():
	odpovedal(2)

func _on_button_3_button_down():
	odpovedal(3)

func _on_button_4_button_down():
	odpovedal(4)

func odpovedal(zadana_odpoved):
	if !zablokovane:
		if zadana_odpoved == vysledok:
			emit_signal("odpoved")
		else:
			zablokovane = true
			cas_zablokovania = 0
