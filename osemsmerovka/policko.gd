extends Button

signal stlacilosa(p)
@onready var obrazok_default = preload("res://osemsmerovka/default.png")
@onready var obrazok_skrt = preload("res://osemsmerovka/skrt.png")
@export var pismeno: String
# Called when the node enters the scene tree for the first time.
func _ready():
	icon = obrazok_default
	$Label.text = pismeno

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func zaskrtnisa():
	icon = obrazok_skrt

func _on_button_down():
	emit_signal("stlacilosa",self)
