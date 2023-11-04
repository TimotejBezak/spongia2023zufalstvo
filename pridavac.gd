extends Button

signal pridavaci_mod_zapnut(pos,pridavac)
signal pridavaci_mod_vypnut()
var je_zapnuty = false
var item_na_mne
var prisiel_teraz = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(item_na_mne)
	pass

func prave_prisiel_item():
	emit_signal("pridavaci_mod_vypnut")
	je_zapnuty = false
	prisiel_teraz = true

func je_item_na_mne():
	if item_na_mne == null or !is_instance_valid(item_na_mne):
		return false
	return true

func _on_button_down():
	je_zapnuty = !je_zapnuty
	if je_zapnuty:
		emit_signal("pridavaci_mod_zapnut",position,self)
	else:
		emit_signal("pridavaci_mod_vypnut")
