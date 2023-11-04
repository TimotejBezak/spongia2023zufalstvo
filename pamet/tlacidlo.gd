extends Button

signal stlacena_farba(f)
@export var farba: int
var farby = [preload("res://pamet/farba0.png"),preload("res://pamet/farba1.png"),preload("res://pamet/farba2.png"),preload("res://pamet/farba3.png")]
# Called when the node enters the scene tree for the first time.
func _ready():
	icon = farby[farba]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_down():
	emit_signal("stlacena_farba",farba)
