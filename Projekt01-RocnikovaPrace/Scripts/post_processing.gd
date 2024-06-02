extends CanvasLayer

func _ready():
	check_for_post_processing()

func check_for_post_processing():
	if Saved.saved_data["settings"]["video"]["post-processing"]: effect_on()
	else: effect_off()

func effect_on():
	$WorldEnvironment.environment = load("res://PostProcessing/effects_on.tres")
	$Retro.show()

func effect_off():
	$WorldEnvironment.environment = load("res://PostProcessing/effects_off.tres")
	$Retro.hide()

func change_brightness(value):
	$WorldEnvironment.environment.adjustment_brightness = value / 10
