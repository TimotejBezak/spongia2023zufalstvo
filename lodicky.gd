extends Node2D

signal stlacilosa(p)
# Called when the node enters the scene tree for the first time.
var pos = {}
var policko_na_pozici = {}
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

var smery_rohy = [
	[1,1],
	[1,-1],
	[-1,1],
	[-1,-1]
]

var smery_strany = [
	[0,1],
	[0,-1],
	[1,0],
	[-1,0]
]
var r = 0
var s = 0
var update_p

func _ready():
	for i in $grid.get_children():
		if i.is_in_group("lode_policko"):
			i.connect("stlacilosa",selectuj)
			pos[i] = [r,s]
			policko_na_pozici[[r,s]] = i
			
			if s < $grid.columns-1-1: 
				s+=1
			else:
				s=0
				r+=1
	s = $grid.columns-1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if update_p != null:
		update_p.typ = nastavit_typ(update_p,true)
		update_p = null
	pass

func selectuj(p,tlacidlo):
	if !p.je_zadany:
		if tlacidlo == "lave":
			if p.typ == 0:
				p.typ = nastavit_typ(p,false)
			else:
				if je_tam_lod(p):
					p.typ = 0
					zmazal_sa(p)
		else:
			if p.typ == 0:
				p.typ = 7
			else:
				if p.typ == 7 and !p.je_zadany_voda:# and p.je_zadany == false:
					p.typ = 0
	
#	if !p.je_zadany:
#		if p.typ == 7 and !p.je_zadany_voda:# and p.je_zadany == false:
#			p.typ = 0
#		else:
#			if p.typ == 0:
#				p.typ = nastavit_typ(p,false)
#			else:
#				if je_tam_lod(p):
#					p.typ = 7
#					zmazal_sa(p)
		
		
func je_tam_lod(p):
	return (p.typ >= 1 and p.typ <= 6)

func je_v_mriezke(pozicia):
	if pozicia[0] < 0 or pozicia[0] >= r:
		return false
	if pozicia[1] < 0 or pozicia[1] >= s:
		return false
	return true

func nastavit_typ(p,je_updat):#nastavujem typ
	for smer in smery_rohy:
		var sused_pos = [pos[p][0]+smer[0],pos[p][1]+smer[1]]
		if je_v_mriezke(sused_pos):
			if je_tam_lod(policko_na_pozici[sused_pos]):
				return 0#susedi rohom
	
	#rohovym smerom nic neni
	var pocet_susedov = 0
	var zadany_sused
	var zadany_sused_smer
	for smer in smery_strany:
		var sused_pos = [pos[p][0]+smer[0],pos[p][1]+smer[1]]
		if je_v_mriezke(sused_pos):
			if policko_na_pozici[sused_pos].je_zadany:
				zadany_sused = policko_na_pozici[sused_pos]
				zadany_sused_smer = smer
			if je_tam_lod(policko_na_pozici[sused_pos]):
				pocet_susedov += 1
				
	if zadany_sused != null:
		var pokracovat = false
		if zadany_sused_smer[0] == 0 and zadany_sused_smer[1] == -1 and zadany_sused.typ == 1:
			pokracovat = true
		if zadany_sused_smer[0] == 0 and zadany_sused_smer[1] == 1 and zadany_sused.typ == 2:
			pokracovat = true
		if zadany_sused_smer[0] == -1 and zadany_sused_smer[1] == 0 and zadany_sused.typ == 3:
			pokracovat = true
		if zadany_sused_smer[0] == 1 and zadany_sused_smer[1] == 0 and zadany_sused.typ == 4:
			pokracovat = true
		if zadany_sused.typ == 5:
			pokracovat = true
		if !pokracovat:
			return 0
			
	if pocet_susedov > 2:
		return 0
	
	if pocet_susedov == 0:
		return 6
	
	if pocet_susedov == 1:
		var smer_suseda
		var sused
		for smer in smery_strany:
			var sused_pos = [pos[p][0]+smer[0],pos[p][1]+smer[1]]
			if je_v_mriezke(sused_pos):
				if je_tam_lod(policko_na_pozici[sused_pos]):
					smer_suseda = smer
					sused = policko_na_pozici[sused_pos]
		
		var vysledok
		if smer_suseda[0] == 0 and smer_suseda[1] == 1:
			vysledok = 1
		if smer_suseda[0] == 0 and smer_suseda[1] == -1:
			vysledok = 2
		if smer_suseda[0] == 1 and smer_suseda[1] == 0:
			vysledok = 3
		if smer_suseda[0] == -1 and smer_suseda[1] == 0:
			vysledok = 4
		if !je_updat and !sused.je_zadany:
			update_p = sused
		return vysledok
	
	if pocet_susedov == 2:
		p.typ = 5
		for smer in smery_strany:
			var sused_pos = [pos[p][0]+smer[0],pos[p][1]+smer[1]]
			if je_v_mriezke(sused_pos):
				var sused = policko_na_pozici[sused_pos]
				if je_tam_lod(sused) and !je_updat:
					print(pos[sused])
					sused.typ = nastavit_typ(sused,true)
		return 5
		
	return 5

func zmazal_sa(p):
	for smer in smery_strany:
		var sused_pos = [pos[p][0]+smer[0],pos[p][1]+smer[1]]
		if je_v_mriezke(sused_pos):
			var sused = policko_na_pozici[sused_pos]
			if je_tam_lod(sused) and !sused.je_zadany:
				sused.typ = nastavit_typ(sused,true)
# 0 - prazdne
# 1-lavo
# 2-pravo
# 3-hore
# 4-dole
# 5-stred
# 6-1
# 7-voda
