extends Node2D

signal odpoved()
@onready var load_hadanka = preload("res://hadanka.tscn")
# Called when the node enters the scene tree for the first time.
var hadanka
var veci = [
	["Koľko nôh má pavúk?","4","6","8","10",3],
	["Koľko zubov má krokodíl nílsky?","52","74","60","42",3],
	["Aká je najväčšia krajina na svete?", "Turecko", "Rusko", "Čína", "India", 2],
	["Aká je rozloha Slovenska?", "35 605", "46 105", "49 035", "53 205", 3],
	["Ktoré ovocie je najkonzumovanejšie?", "banán", "jablko", "pomaranč", "červený melón", 1],
	["Koľko rokov má Joe Biden (1.1.2023)?", "89", "73", "82", "76", 2],
	["V ktorom storočí sa stala prvá priemyselná revolúcia?", "19.", "17.", "18.", "16.", 3],
	["Ako sa volal prvý maďarský kráľ?", "Lászlo", "Béla", "Ištván", "Štefan", 4],
	["Aké je protónové číslo zlata?", "42", "62", "79", "117", 3],
	["Kto napísal literárne dielo Slávy dcéra?", "J. Palárik", "J. Botto", "J.Kollár", "J. Kráľ", 3]
]
var index_hadanky = 0
func _ready():
	nacitaj_hadanku()

func nacitaj_hadanku():
	hadanka = load_hadanka.instantiate()
	hadanka.connect("odpoved",dalsiu)
	add_child(hadanka)
	hadanka.nastav_texty(veci[index_hadanky])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func dalsiu():
	remove_child(hadanka)
	index_hadanky += 1
	if index_hadanky == len(veci):
		global.mam_vyriesene_hadanky = true
	else:
		nacitaj_hadanku()
