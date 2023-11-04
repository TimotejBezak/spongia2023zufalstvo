extends Node2D

@export var strana = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	if strana == 0:
		$papier.texture = load("res://grafika/noviny_lavo.png")
	else:
		$papier.texture = load("res://grafika/noviny_pravo.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
