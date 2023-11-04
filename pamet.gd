extends Node2D

signal stlacena_farba(f)

var cas_farby = 1.3
var cas_oddelovaca = 0.1
var cas
var sekvencia
var idx_sekvencie
var blikam = false
var mozem_stlacat = false
var levely = [1,2,3]
var idx_level = 0
var cas_ukazania
var vyhral = false
var uplny_koniec = false
@onready var farby = [preload("res://pamet/farba0.png"),preload("res://pamet/farba1.png"),preload("res://pamet/farba2.png"),preload("res://pamet/farba3.png")]
@onready var oddelovac = preload("res://pamet/oddelovac.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	$tlacidlo.connect("stlacena_farba",stlacena_farba1)
	$tlacidlo2.connect("stlacena_farba",stlacena_farba1)
	$tlacidlo3.connect("stlacena_farba",stlacena_farba1)
	$tlacidlo4.connect("stlacena_farba",stlacena_farba1)
	#zacni_blikat(9)

func zacni_blikat(dlzka_sekvencie):
	blikam = true
	cas = 0
	sekvencia = []
	randomize()
	for i in range(dlzka_sekvencie):
		sekvencia.push_back(int(randf_range(0,3.999)))
	idx_sekvencie = 0
	$menic.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if blikam:
		$menic.texture = farby[sekvencia[idx_sekvencie]]
		if cas >= cas_farby:
			if cas >= cas_farby+cas_oddelovaca:
				idx_sekvencie += 1
				if idx_sekvencie == len(sekvencia):
					print("koniec")
					blikam = false
					$menic.visible = false
					idx_sekvencie = 0
				cas = 0
			else:
				$menic.texture = oddelovac
		cas += delta
		
	if cas_ukazania != null:
		if cas_ukazania <= 0:
			$info.text = ""
		cas_ukazania -= delta

		
func stlacena_farba1(farba):
	if !blikam:
		if mozem_stlacat:
			if sekvencia[idx_sekvencie] == farba:
				idx_sekvencie += 1
				if idx_sekvencie == len(sekvencia):
					povedz_info("cele si to zvladol",1000000)
					$dalsi_level/Label.text = "dalsi level"
					vyhral = true
					mozem_stlacat = false
					if idx_level == len(levely)-1:
						uplny_koniec = true
						povedz_info("presiel si vsetko, mas nakalibrovanu palicku",1000000)
						$dalsi_level/Label.text = ""
						global.mas_nakalibrovanu_palicku = true
				else:
					povedz_info("spravne",0.5)
			else:
				mozem_stlacat = false
				povedz_info("nespravne, mozes restartovat",1000000)
				$dalsi_level/Label.text = "restart"

func povedz_info(text,cas):
	cas_ukazania = cas
	$info.text = text

func _on_dalsi_level_button_down():
	if !uplny_koniec:
		$info.text = ""
		$dalsi_level/Label.text = ""
		mozem_stlacat = true
		if vyhral:
			vyhral = false
			idx_level += 1
		zacni_blikat(levely[idx_level])
		
