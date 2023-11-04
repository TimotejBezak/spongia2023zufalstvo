extends Node2D

signal pridat_do_inventaru(item)
var zobrazenie = false
var schovanie = false
var rozsah_hybania = [0,950]#x
var je_zobrazeny = false
var pridavaci_mod = false
var itemy = []
# Called when the node enters the scene tree for the first time.
func _ready():	
	$veci.position.x = rozsah_hybania[1]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#visible = !$zobrazit.button_pressed
	var v_animacie = 1020
	if zobrazenie:
		$veci.position.x -= v_animacie*delta
		if $veci.position.x <= rozsah_hybania[0]:
			$veci.position.x = rozsah_hybania[0]
			zobrazenie = false
			$zobrazit.disabled = false
	if schovanie:
		$veci.position.x += v_animacie*delta
		if $veci.position.x >= rozsah_hybania[1]:
			$veci.position.x = rozsah_hybania[1]
			schovanie = false
			$zobrazit.disabled = false

func pridat(item):
	#print(item)
	if item.je_v_scene:
		global.veci_ktore_uz_niekedy_boli_v_inventari.push_back(item.meno)
		var novy = item.duplicate()
		#item.visible = false
		#item.disabled = true
		itemy.erase(item)#.remove(itemy.find(item))
		item.queue_free()
		novy.je_v_scene = false#bol zobraty zo sceny
		itemy.push_back(novy)
		#item.queue_free()
		#item.je_v_scene = false
		#print(item)
		$veci/GridContainer.add_child(novy)
		#global.inventar.push_back(novy.meno)
		return novy


func _on_zobrazit_toggled(button_pressed):
	if !global.mas_otvorene_noviny:
		$zobrazit.disabled = true
		if !je_zobrazeny:
			zobrazenie = true
			je_zobrazeny = true
			#$veci.position.x = 800
		else:
			schovanie = true
			je_zobrazeny = false
			#$veci.position.x = 0

func zobrazit():
	if !je_zobrazeny:
		zobrazenie = true
		je_zobrazeny = true
		#$zobrazit.disabled = true

func pridavanie_zapni(pos):
	pridavaci_mod = true
#	je_zobrazeny = true
	for i in itemy:
		i.pridavaci_mod = true
		i.kam_do_sceny_pridat = pos
	zobrazit()

func pridavanie_vypni():
	pridavaci_mod = false
	for i in itemy:
		i.pridavaci_mod = false
		i.kam_do_sceny_pridat = null
	
