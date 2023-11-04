extends Button

signal stlacene_tlacidlo_presunut()

@export var kam: int
var popis = [-1, "izba","les","kamarát","predajna kabatov","elixíry","zahrada","palicka","ist dalej","jaskyna","ist dalej","rebrik","kniznica","nahoda","cakanie","doprava","dolava","doprava","dolava","dolava","rovno","doprava","doprava","rovno","dolava","dolava","dolava","dolava","doprava","doprava","doprava","dolava","doprava","rovno","dolava","rovno","doprava","dolava","doprava","rovno","dolava","doprava","rovno","doprava","rovno","dolava","rovno","doprava","dolava","rovno"]
# Called when the node enters the scene tree for the first time.
var cas
var limit = 1
var cas_ukazania
var som_tlacidlo_naspet = false
func _ready():
	$Label.text = popis[kam]
	if som_tlacidlo_naspet and kam > 14:
		$Label.text = "naspet"
		
	if kam == 9 or kam == 12:
		visible = global.bol_si_u_kamarata

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cas != null:
		cas += delta
		if cas >= limit:
			get_tree().change_scene_to_file("res://miestnosti//"+str(kam)+".tscn")
			#print(global.sceny[kam])
			#get_tree().change_scene_to_packed(global.sceny[kam])
			
	if cas_ukazania != null:
		if cas_ukazania <= 0:
			$neda_sa.text = ""
		cas_ukazania -= delta
		
#func _on_button_down():
#	cas = 0
#	print("tuk")
#	emit_signal("presun")


func _on_button_down():
	if !global.zablokovat_presun and !global.mas_otvorene_noviny:
		var pokracujem = true
		if kam == 9 and !global.mas_nakalibrovanu_palicku:#jaskyna
			pokracujem = false
			povedz_info("carodejnik sa do jaskyne bez nakalibrovanej palicky neodvazi",3)
		if kam == 13 and !global.mam_vyriesene_hadanky:
			pokracujem = false
			povedz_info("este si neodpovedal na hadanky",3)
		if kam == 14 and !global.mam_hodene_6:
			pokracujem = false
			povedz_info("duch ta nepusti dalej kym nehodis tri sestky",3)
#		if kam == 9 and !global.spravne_heslo_zadane:
#			pokracujem = false
#			povedz_info("najprv zadaj heslo",3)
		if kam == 8 and !global.vyliezol_po_rebriku:
			pokracujem = false
			povedz_info("bez rebriku sa dalej nedostanes",3)
		if kam == 10 and !global.nahucal_si:
			pokracujem = false
			povedz_info("prisera ti stoji v ceste",3)
			
		if pokracujem:
			cas = 0
			emit_signal("stlacene_tlacidlo_presunut")
	#get_tree().change_scene("res://miestnosti//"+str(kam)+".tscn")

func povedz_info(text,cas):
	cas_ukazania = cas
	$neda_sa.text = text
