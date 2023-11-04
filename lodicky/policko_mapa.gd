extends Button

@onready var obrazky = [preload("res://osemsmerovka/default.png"),preload("res://lodicky/voda.png")]
@export var pismeno: String
var idx = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = pismeno

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	icon = obrazky[idx]

func _on_button_down():
	if idx == 0:
		idx = 1
	else:
		idx = 0
