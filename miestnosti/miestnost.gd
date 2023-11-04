extends Node2D

signal pridat_do_inventaru(item)
signal pridavaci_mod_zapnut(pos)
signal pridavaci_mod_vypnut()
signal item_sa_sunie_do_sceny(item)
signal item_sa_dosunul_do_sceny(item)
signal uvaril_sa(item)

@export_global_file("*.png") var obrazok_pozadie
@export var kam_dalej: Array[int]
@export var kam_spet: int
@onready var presun_load = preload("res://presunut.tscn")
@onready var tlacidla_presun_tam = get_node("miestnost/tlacidla_presun_tam")
@onready var tlacidla_presun_spet = get_node("miestnost/tlacidla_presun_spet")
@onready var pozadie = get_node("miestnost/Pozadie1")
@onready var inventar = get_node("miestnost/inventar")
@onready var carodejnik = get_node("miestnost/carodejnik")
var aktivny_pridavac
# Called when the node enters the scene tree for the first time.
func _ready():
	#$peniaze.text = "peniaze: "#+str(global.peniaze)
	$miestnost/peniaze/peniazky.text = str(global.peniaze)
	
	if !global.sceny_prvy_krat[name.to_int()]:
		for i in $zbieracie_veci.get_children():
			if i.meno in global.veci_ktore_uz_niekedy_boli_v_inventari:
				i.queue_free()
	else:
		$basnicka.stream = load($basnicka.path)
		$basnicka.play()
	
	for i in global.inventar:
		inventar.get_node("veci").get_node("GridContainer").add_child(i)
	
	for i in inventar.get_node("veci").get_node("GridContainer").get_children():
		inventar.itemy.push_back(i)
		i.connect("pridat_do_inventaru",inventar.pridat)
		i.connect("item_sa_sunie_do_sceny",item_sa_sunie_do_sceny1)
	#potialto to bolo v inventar.gd
	
	for i in kam_dalej:
		var novy = presun_load.instantiate()
		novy.kam = i
		novy.connect("stlacene_tlacidlo_presunut",stlacene)
		tlacidla_presun_tam.add_child(novy)
	if kam_spet != 0:
		var novy = presun_load.instantiate()
		novy.kam = kam_spet
		novy.som_tlacidlo_naspet = true
		novy.connect("stlacene_tlacidlo_presunut",stlacene)
		tlacidla_presun_spet.add_child(novy)
	
	pozadie.texture = load(obrazok_pozadie)
	for i in $zbieracie_veci.get_children():
		i.connect("pridat_do_inventaru",pridat_do_inventara)

	for i in get_children():
		if i.is_in_group("pridavac"):
			i.connect("pridavaci_mod_zapnut",pridavanie_zapni1)
			i.connect("pridavaci_mod_vypnut",inventar.pridavanie_vypni)
		for j in i.get_children():
			if j.is_in_group("pridavac"):
				j.connect("pridavaci_mod_zapnut",pridavanie_zapni1)
				j.connect("pridavaci_mod_vypnut",inventar.pridavanie_vypni)
		if i.is_in_group("varenie"):
			i.connect("uvaril_sa",navaril_sa1)
	
	global.sceny_prvy_krat[name.to_int()] = false
	
func navaril_sa1(item):
	$zbieracie_veci.add_child(item)
	item.connect("pridat_do_inventaru",pridat_do_inventara)

func pridavanie_zapni1(pos,pridavac):
	inventar.pridavanie_zapni(pos)
	aktivny_pridavac = pridavac

# Called every frame. 'delta' is the elapsed time since the previous frame.
func pridat_do_inventara(item):
	var novy = inventar.pridat(item)
	novy.connect("item_sa_sunie_do_sceny",item_sa_sunie_do_sceny1)

func item_sa_dosunul_do_sceny1(item):
	if aktivny_pridavac != null:
		aktivny_pridavac.item_na_mne = item
		aktivny_pridavac.prave_prisiel_item()

func item_sa_sunie_do_sceny1(item):
	var novy = item.duplicate()
	novy.pridavaci_mod = item.pridavaci_mod
	novy.kam_do_sceny_pridat = item.kam_do_sceny_pridat
	novy.cestuje_do_sceny = item.cestuje_do_sceny
	novy.position = inventar.get_node("veci").get_node("GridContainer").position + item.position
	novy.connect("item_sa_dosunul_do_sceny",item_sa_dosunul_do_sceny1)
	novy.connect("pridat_do_inventaru",pridat_do_inventara)
	inventar.itemy.erase(item)
	item.queue_free()
	$zbieracie_veci.add_child(novy)
	#print("stalosa")
	
	inventar.pridavanie_vypni()

func _process(delta):
	pass

func stlacene():
	global.inventar = []
	for i in inventar.itemy:
		var novy = i.duplicate()
		novy.je_v_scene = false
		global.inventar.push_back(novy)
	carodejnik.koniec()
