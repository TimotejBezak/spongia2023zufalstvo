extends Node2D

@onready var icon = $Node2D/Icon
# Called when the node enters the scene tree for the first time.
func _ready():
	#icon.rotation = 0#rad_to_deg(90)
	#$Node2D.rotation = deg_to_rad(90)
	#icon.rotation = deg_to_rad(-90)
	#icon.position.x = -65
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Node2D.skew+=delta*0.5
	pass
