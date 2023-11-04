extends Node2D

signal uvaril_sa(item)

var dary = ["záhradné rukavice", "sada na cistenie","flaša medoviny"]
@onready var stvorlistok = preload("res://grafika/itemy/stvorlistok.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $pridavac.je_item_na_mne():
		for dar in dary:
			if $pridavac.item_na_mne.meno == dar:
				var uvarenec = load("res://item_inventaru.tscn").instantiate()
				uvarenec.meno = "stvorlistok"
				uvarenec.icon = stvorlistok
				uvarenec.position = Vector2(1400,500)
				uvarenec.visible = true
				print("bubu")
				emit_signal("uvaril_sa",uvarenec)
				$Label.text = "dakujem ti za stedry dar, za odmenu ti ponukam tento stvorlistok pre stastie"
				global.bol_si_u_kamarata = true
				$pridavac.item_na_mne.queue_free()
				$pridavac.visible = false
				break
