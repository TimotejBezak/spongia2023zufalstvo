extends Node2D

var kocky = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_children():
		if i.is_in_group("kocka"):
			kocky.push_back(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var su_vsetky_hodene = true
	for i in kocky:
		if !i.je_hodena:
			su_vsetky_hodene = false

	var su_vsetky_6 = false
	if su_vsetky_hodene:
		su_vsetky_6 = true
		for i in kocky:
			if i.hodnota != 6:
				su_vsetky_6 = false

	if su_vsetky_6:
		global.mam_hodene_6 = true
		
func _on_reset_button_down():
	for i in kocky:
		i.reset()
