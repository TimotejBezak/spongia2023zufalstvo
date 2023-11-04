extends Node2D

signal stlacena_farba(f)
var poradie
var dlzka = 7
var pocet_farieb = 4
var poradie_idx = 0
var timer = Timer.new()
var farby = [preload("res://pamet/farba0.png"),preload("res://pamet/farba1.png"),preload("res://pamet/farba2.png"),preload("res://pamet/farba3.png")]
var ukazuje_farby = true
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_children():
		if i.is_in_group("tlacidlo_farba"):
			i.connect("stlacena_farba",stlacila_sa_farba)

	poradie = []
	poradie_idx = 0
	for i in range(dlzka):
		randomize()
		poradie.push_back(randi_range(0,pocet_farieb-1))
	
	timer.connect("timeout",nova_farba)
	timer.wait_time = 1
	timer.one_shot = false
	add_child(timer)
	
	zacat_blikanie()

func zacat_blikanie():
	nova_farba()
	timer.start()

func nova_farba():
	$svetlo.texture = farby[poradie[poradie_idx]]
	poradie_idx += 1
	if poradie_idx == len(poradie):
		timer.stop()
		ukazuje_farby = false
		poradie_idx = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func stlacila_sa_farba(f):
	if ukazuje_farby == false:
		if f == poradie[poradie_idx]:
			print("spravne")
		else:
			print("zle")
		poradie_idx += 1
		if poradie_idx == len(poradie):
			print("cele_dobre")
			ukazuje_farby = true
