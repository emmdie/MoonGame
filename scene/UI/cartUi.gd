extends Node2D
var ammoMax
var ammoCurrent
var reloading = false

func _ready():
	pass

func _process(delta):
	if (reloading ==true):
		$ProgressBar.value = 100 * (1-($ReloadTimer.time_left /$ReloadTimer.wait_time+0.00001))
	
func updateLabel():
	$AmmoLabel.text = str(ammoCurrent)+"/"+str(ammoMax)
	
func reload(duration):
	reloading = true
	$AmmoLabel.visible = false
	$ReloadTimer.wait_time = duration
	$ReloadTimer.start(duration)
	$ProgressBar.visible = true

func _on_ReloadTimer_timeout():
	$AmmoLabel.visible = true
	$ProgressBar.visible = false
	reloading = false
	ammoCurrent = ammoMax
	updateLabel()

func shoot():
	ammoCurrent -= ammoCurrent
	updateLabel()
