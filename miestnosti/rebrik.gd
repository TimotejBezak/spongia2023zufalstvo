extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$rebriky.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $pridavac.je_item_na_mne():
		if $pridavac.item_na_mne.meno == "rebrik":
			$pridavac.item_na_mne.queue_free()
			$rebriky.visible = true
			$pridavac.visible = false
			global.vyliezol_po_rebriku = true
