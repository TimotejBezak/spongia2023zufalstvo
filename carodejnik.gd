#extends Node2D
#
#var cas = 0
#var cas_frame = 0.1#1/10
#var frame = 8
#var pocet_framov = 9
#func _ready():
#	#$animacia.frame = frame
#	pass
#
#func _process(delta):
#	cas += delta
#	if cas > frame*cas_frame:
#		frame -= 1
#	$animacia.frame = frame
#	if frame < 0:
#		$animacia.visible = false
#
#
#func _on_animated_sprite_2d_animation_finished():
#	print("teraz")
#	#$AnimatedSprite2D.stop()




#extends Node2D
#
##signal presun()
#@export var kam: int
## Called when the node enters the scene tree for the first time.
#var krutit_koniec = false
#var krutit_zaciatok = false
#var rychlost_krutenia = 480
#var rychlost_scale = 8
#var cas
#var limit = 1.5
#func _ready():
#	zaciatok()
	#pass
	#$presunut.connect("presun",koniec)

#func koniec():
#	global.zablokovat_presun = true
#	krutit_koniec = true
#	cas = 0
#
#func zaciatok():
#	scale = Vector2(27.7,27.7)
#	krutit_zaciatok = true
#	cas = 0
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if krutit_koniec:
#		rotate(deg_to_rad(rychlost_krutenia*delta))
#		var nasobok = 1+cas*cas*cas*rychlost_scale
#		scale.x = nasobok
#		scale.y = nasobok
#		#print(scale,"  ",int(rad_to_deg(rotation))%360)
#		cas += delta
#		if cas >= limit:
#			krutit_koniec = false
#			#print(scale.x)
#			#get_tree().change_scene_to_file("res://miestnosti//"+str(kam)+".tscn")
#
#	if krutit_zaciatok:
#		rotate(deg_to_rad(rychlost_krutenia*delta))
#		var nasobok = 1+(limit-cas)*(limit-cas)*(limit-cas)*rychlost_scale
#		scale.x = nasobok
#		scale.y = nasobok
#		cas += delta
#		if cas >= limit:
#			krutit_zaciatok = false
#			scale.x = 1
#			scale.y = 1
#			rotation = 0
#			global.zablokovat_presun = false


extends Node2D

#signal presun()
@export var kam: int
# Called when the node enters the scene tree for the first time.
var animacia = []
var krutit_koniec = false
var krutit_zaciatok = false
var cas
var limit = 1.2
var pocet_framov = 9
var idx_frame = 0
@onready var default_obrazok = preload("res://grafika/animacia_carodejnik/wizard1.png")
func _ready():
	for i in range(pocet_framov):
		animacia.push_back(load("res://grafika/animacia_carodejnik/wizard"+str(i+1)+".png"))
	zaciatok()
	#pass
	#$presunut.connect("presun",koniec)

func koniec():
	global.zablokovat_presun = true
	krutit_koniec = true
	cas = 0
	animacia.reverse()
#
func zaciatok():
	krutit_zaciatok = true
	animacia.reverse()
	cas = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if krutit_koniec:
		
		#print(scale,"  ",int(rad_to_deg(rotation))%360)
		cas += delta
		if cas >= (idx_frame+1)*float(limit/pocet_framov):
			idx_frame += 1
			if idx_frame < len(animacia):
				$Sprite2D.texture = animacia[idx_frame]
		
		if cas >= limit:
			krutit_koniec = false
			idx_frame = 0
			#print(scale.x)
			#get_tree().change_scene_to_file("res://miestnosti//"+str(kam)+".tscn")

	if krutit_zaciatok:
		
		cas += delta
		if cas >= (idx_frame+1)*float(limit/pocet_framov):
			idx_frame += 1
			if idx_frame < len(animacia):
				$Sprite2D.texture = animacia[idx_frame]
		
		if cas >= limit:
			krutit_zaciatok = false
			global.zablokovat_presun = false
			$Sprite2D.texture = default_obrazok
			idx_frame = 0
