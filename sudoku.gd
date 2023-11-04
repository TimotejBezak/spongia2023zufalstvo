extends Node2D
#@export var r: int
#@export var s: int
signal stlacene(p)

@onready var policko = preload("res://krizovka//policko.tscn")
@onready var grid = get_node("GridContainer")
@onready var mys_je_dnu = false
var selected: Button
var cas_od_selectu = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in grid.get_children():
		i.connect("stlacene",selectuj)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cas_od_selectu += delta
	if cas_od_selectu > 0.2:
		if Input.is_action_just_pressed("lave_mys"):
			print("tuk", selected)
			#if mys_je_dnu == false:
			if selected != null:
				selected.icon = selected.obrazok[selected.typ]#
			selected = null

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed:
			if selected != null:
				var pismeno = event.keycode
				if pismeno >= 48 and pismeno <= 57:
					selected.label_pismeno.text = char(pismeno)
				#if pismeno == MOUSE_BUTTON_LEFT:
				#	print("bu")S
				#	selected = null
				
	#if event is InputEventMouseButton:
	#	if event.pressed:#event.button_index == 0 and 

func selectuj(p):
	cas_od_selectu = 0
	if selected != null:
		selected.icon = selected.obrazok[selected.typ]
	if p.typ == 0 or p.typ == 1:
		selected = p
		p.icon = p.obrazok_select[p.typ]
	else:
		selected = null

func _on_grid_container_mouse_entered():
	#print("dnu")
	mys_je_dnu = true


func _on_grid_container_mouse_exited():
	#print("von")
	mys_je_dnu = false
