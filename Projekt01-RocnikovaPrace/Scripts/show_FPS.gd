extends CanvasLayer

func _physics_process(_delta):
	$Fps.text = "fps:" + str(Engine.get_frames_per_second())

func hide_or_show(what):
	$Fps.visible = what
