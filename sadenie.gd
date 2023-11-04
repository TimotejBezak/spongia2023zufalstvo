extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $pridavac.je_item_na_mne():
		if $pridavac.prisiel_teraz and $pridavac.item_na_mne.meno == "semienko":
			$pridavac.item_na_mne.meno = "palica"
			$pridavac.item_na_mne.icon = load("res://grafika/itemy/palica.png")
			#zmenit aj texturu
