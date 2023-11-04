extends Button

@export var cislo: String
# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = cislo


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
