extends Node2D

@export var doprava: String
@export var dole: String
# Called when the node enters the scene tree for the first time.
func _ready():
	if doprava == "" or dole == "":
		$predelovac.visible = false
		$label_doprava.visible = false
		$label_dole.visible = false
		var dlhsi = dole
		if len(doprava) > len(dole):
			dlhsi = doprava
		$label_cele.text = dlhsi
	else:
		$label_cele.visible = false
		$label_doprava.text = doprava
		$label_dole.text = dole

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
