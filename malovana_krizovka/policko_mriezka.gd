extends Button

@onready var obrazky = [preload("res://malovana_krizovka/nevyplnene.png"),preload("res://malovana_krizovka/plne.png"),preload("res://malovana_krizovka/prazdne.png")]
var icon_idx = 0# Called when the node enters the scene tree for the first time.
func _ready():
	icon = obrazky[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_down():
	if Input.is_action_just_pressed("lave_mys"):
		if icon_idx == 0 or icon_idx == 2:
			icon_idx = 1
		elif icon_idx == 1:
			icon_idx = 0
	elif Input.is_action_just_pressed("prave_mys"):
		if icon_idx == 0 or icon_idx == 1:
			icon_idx = 2
		elif icon_idx == 2:
			icon_idx = 0
	icon = obrazky[icon_idx]
