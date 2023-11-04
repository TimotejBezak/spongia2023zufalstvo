extends Node2D
#@export var r: int
#@export var s: int
signal stlacene(p)

@onready var policko = preload("res://krizovka//policko.tscn")
@onready var grid = get_node("GridContainer")
@onready var mys_je_dnu = false
var selected: Button
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in grid.get_children():
		i.connect("stlacene",selectuj)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var heslo = ["1","6","3","3","2"]
	if $GridContainer/policko.label_pismeno.text == "1" and $GridContainer/policko2.label_pismeno.text == "6" and $GridContainer/policko3.label_pismeno.text == "3" and $GridContainer/policko4.label_pismeno.text == "3" and $GridContainer/policko5.label_pismeno.text == "2":
		global.spravne_heslo_zadane = true
		global.peniaze += 250
		$Label.text = "zadal si spravne heslo, v truhlici si nasiel 250 penazi"

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed:
			if selected != null:
				var pismeno = event.keycode
				if pismeno >= 48 and pismeno <= 48+9:
					print(selected.label_pismeno.text)
					selected.label_pismeno.text = char(pismeno)
				if pismeno == KEY_BACKSPACE:
					selected.label_pismeno.text = ""
				#if pismeno == MOUSE_BUTTON_LEFT:
				#	print("bu")S
				#	selected = null
	if event is InputEventMouseButton:
		if event.pressed:#event.button_index == 0 and 
			if mys_je_dnu == false:
				selected = null

func selectuj(p):
	if selected != null:
		selected.icon = selected.obrazok[selected.typ]
	if p.typ != 2:
		selected = p
		p.icon = p.obrazok_select[p.typ]
	else:
		selected = null


func _on_grid_container_mouse_entered():
	mys_je_dnu = true


func _on_grid_container_mouse_exited():
	mys_je_dnu = false
