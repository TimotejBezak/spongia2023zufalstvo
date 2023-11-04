extends Button

signal stlacilosa(p,tlacidlo)
@onready var obrazky = [preload("res://lodicky/prazdne.png"),preload("res://lodicky/dolava.png"),preload("res://lodicky/doprava.png"),preload("res://lodicky/hore.png"),preload("res://lodicky/dole.png"),preload("res://lodicky/stred.png"),preload("res://lodicky/1.png"),preload("res://lodicky/voda.png")]
@export var typ = 0
var je_zadany = false
var je_zadany_voda = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if typ != 0 and typ != 7:
		je_zadany = true
	if typ == 7:
		je_zadany_voda = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	icon = obrazky[typ]

#func _on_button_down():
#	emit_signal("stlacilosa",self)


func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				emit_signal("stlacilosa",self,"lave")
			MOUSE_BUTTON_RIGHT:
				emit_signal("stlacilosa",self,"prave")
