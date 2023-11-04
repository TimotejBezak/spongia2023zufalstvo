extends AudioStreamPlayer

var record_bus_index: int
#var prehravac_bus_index: int
var record_effect: AudioEffectRecord
var recording#: AudioStreamSample

# Called when the node enters the scene tree for the first time.
func _ready():
	#ProjectSettings.set_setting("audio/driver/enable_input",true)
	#ProjectSettings.save()
	record_bus_index = AudioServer.get_bus_index("Record")
	#prehravac_bus_index = AudioServer.get_bus_index("Record")
	record_effect = AudioServer.get_bus_effect(record_bus_index, 0)
	record_effect.set_recording_active(true)
	
	
	#recording.set_mix_rate(mix_rate)
	#recording.set_format(format)
	#recording.set_stereo(stereo)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if record_effect.is_recording_active():
	#recording = effect.get_recording()
		recording = record_effect.get_recording()
		record_effect.set_recording_active(false)
		record_effect.set_recording_active(true)
		#print(recording)	
		#$prehravac.stream = recording
		#$prehravac.play()
		var sample = AudioServer.get_bus_peak_volume_left_db(record_bus_index,0)
		var linear_sample = db_to_linear(sample)
		$ProgressBar.value = linear_sample*1000/3/2
		if $ProgressBar.value >= 100:
			global.nahucal_si = true
		#recording.save_to_wav("test.wav")
		#effect.set_recording_active(false)
