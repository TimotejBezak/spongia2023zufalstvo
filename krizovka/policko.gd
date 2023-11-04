extends Button

signal stlacene(p)
@export var typ: int
@export var doprava: String
@export var dole: String
@onready var obrazok = [preload("res://krizovka/normalne_policko.png"), preload("res://krizovka/tajnicka_policko.png"), preload("res://krizovka/napoveda_policko_normalne.png"), preload("res://krizovka/hint_policko.png"), preload("res://krizovka/tajnicka_cislo_policko.png")]
@onready var obrazok_select = [preload("res://krizovka/normalne_policko_select.png"), preload("res://krizovka/tajnicka_policko_select.png")]
@onready var label_pismeno_load = preload("res://krizovka//label_pismeno.tscn")
@onready var label_napoveda_load = preload("res://krizovka//label_napoveda.tscn")
var label_pismeno: Label
var label_napoveda: Node2D

#typ 3 je napoveda
#typ 4 je cislo tajnicky

# Called when the node enters the scene tree for the first time.
func _ready():
	icon = obrazok[typ]
	if typ == 2:
		label_napoveda = label_napoveda_load.instantiate()
		label_napoveda.doprava = doprava
		label_napoveda.dole = dole
		add_child(label_napoveda)
	if typ == 0 or typ == 1:
		label_pismeno = label_pismeno_load.instantiate()
		add_child(label_pismeno)
	if typ == 3:
		label_napoveda = label_napoveda_load.instantiate()
		label_napoveda.doprava = "Nápoveda: "+doprava
		add_child(label_napoveda)
	if typ == 4:
		label_napoveda = label_napoveda_load.instantiate()
		label_napoveda.doprava = doprava
		add_child(label_napoveda)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_down():
	emit_signal("stlacene",self)
