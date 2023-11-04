extends Node2D

var obrazky = []
@onready var nic = preload("res://grafika/kocka/nic.png")
var je_hodena = false
var hodnota
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = nic
	for i in range(1,7):
		var path = "res://grafika/kocka/"+str(i)+".png"
		obrazky.push_back(load(path))
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset():
	je_hodena = false
	hodnota = null
	$Button.disabled = false
	$Sprite2D.texture = nic

func _on_button_button_down():
	je_hodena = true
	$Button.disabled = true
	randomize()
	hodnota = int(randf_range(1,6.99))
	$Sprite2D.texture = obrazky[hodnota-1]
