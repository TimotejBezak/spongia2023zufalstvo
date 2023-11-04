extends Node2D

var cas_ukazania
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cas_ukazania != null:
		if cas_ukazania <= 0:
			$info.text = ""
			pass
		cas_ukazania -= delta


func _on_kupit_button_down():
	if global.peniaze >= 500:
		print("vyhral si")
	else:
		povedz_info("nemas dost penazi",1.5)

func povedz_info(text,cas):
	cas_ukazania = cas
	$info.text = text
