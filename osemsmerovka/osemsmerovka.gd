extends Node2D

signal stlacilosa(p)
# Called when the node enters the scene tree for the first time.
var pos = {}
var policko_na_pozici = {}
var suradnice_minule
var smery = [
	[0,1],
	[0,-1],
	[1,1],
	[1,-1],
	[1,0],
	[-1,1],
	[-1,-1],
	[-1,0]
]
var kurzor_minule

var slova = ["KÚZELNÍK","KLOBÚK", "ZAKLÍNADLO", "KLIATBA", "PRÍŠERA", "STRAŠIDLO", "JAŠTERE", "TELEPAT", "LEKTVAR", "KÚZLO", "ČARY", "ZRKADLO", "LEGENDA", "BELZEBUB", "SMRTKA", "KABÁT", "ČIŽMA", "KLAVÍR", "SVIEČKA", "DELOMET", "MEDIAR", "STRACH", "KRYPTA", "KATAKOMBY", "ATRAMENT", "MÁGIA", "OTVORY", "PRÍPRAVAČAJU", "ABRAKADABRA", "TRÁVA", "KARTY", "KRYSY", "HOKUS", "POKUS", "ŽIARA", "ČREP", "ROBOT", "PLAMEŇ", "ELIXÍR"]
#@onready var stlpce = $grid.columns
#var riadky
func _ready():
	$ciara.visible = false
	var r = 0
	var s = 0
	for i in $grid.get_children():
		i.connect("stlacilosa",selectuj)
		pos[i] = [r,s]
		policko_na_pozici[[r,s]] = i
		
		if s < $grid.columns-1: 
			s+=1
		else:
			s=0
			r+=1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if suradnice_minule != null:
		#ciara od kurzor_minule ku kurzoru myse
		var kurzor = get_viewport().get_mouse_position()
		var offset = Vector2(-position.y,position.x) + Vector2(914,421) + Vector2(47,85)
		#print(offset)#980, 4
		$ciara.points[0] = kurzor-offset#Vector2(-(kurzor-offset).y,(kurzor-offset).x)
		$ciara.points[1] = kurzor_minule-offset#Vector2(-(kurzor_minule-offset).y,(kurzor_minule-offset).x)
		$ciara.visible = true
	else:
		$ciara.visible = false
	#print($ciara.points,$ciara.visible)


func selectuj(p):
	var suradnice_na_zaciatku = pos[p].duplicate()
	var suradnice = suradnice_na_zaciatku.duplicate()
	#print("selectuj  ",suradnice, suradnice_minule)
	var sedi_slovo = false
	var najdene_slovo
	if suradnice_minule != null:
		for smer in smery:
			if abs(Vector2(smer[0],smer[1]).normalized() - Vector2(suradnice_minule[0]-suradnice[0],suradnice_minule[1]-suradnice[1]).normalized()).length() < 0.0001:
				var slovo = ""
				slovo += policko_na_pozici[suradnice].pismeno
				while true:
					suradnice[0] += smer[0]
					suradnice[1] += smer[1]
					slovo += policko_na_pozici[suradnice].pismeno
					if suradnice[0] == suradnice_minule[0] and suradnice[1] == suradnice_minule[1]:
						var slovo_naopak = slovo
						slovo = reverse_string(slovo)
						#print("sedi")
						if slovo in slova or slovo_naopak in slova:
							if slovo in slova:
								najdene_slovo = slovo
							else:
								najdene_slovo = slovo_naopak
							sedi_slovo = true
							#zaskrtnut
							suradnice = suradnice_na_zaciatku
							policko_na_pozici[suradnice].zaskrtnisa()
							while true:
								suradnice[0] += smer[0]
								suradnice[1] += smer[1]
								policko_na_pozici[suradnice].zaskrtnisa()
								if suradnice[0] == suradnice_minule[0] and suradnice[1] == suradnice_minule[1]:
									break
						break
				break
	if sedi_slovo:
		suradnice_minule = null
		var duplikat = $ciara.duplicate()
		duplikat.points = $ciara.points.duplicate()
		add_child(duplikat)
		#zmazat z textu
		$slova.text = $slova.text.replace(najdene_slovo,"[color=#ff0000]"+najdene_slovo+"[/color]")#[color=#4ab3ff]blue[/color]
	else:
		if suradnice_minule == null:
			suradnice_minule = pos[p]
			kurzor_minule = get_viewport().get_mouse_position()
		else:
			suradnice_minule = null

func reverse_string(s):
	var r := "" 
	for i in range(s.length()-1, -1, -1):
		r += s[i]
	return r
