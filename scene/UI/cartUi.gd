extends Node2D
export var ammoMax = 10
export var ammoCurrent = 0
var reloading = false

func _ready():
	reload(3)

func _process(delta):
	if (reloading ==true):
		$ProgressBar.value = 100 * (1-($ReloadTimer.time_left /$ReloadTimer.wait_time+0.00001))
	
func updateLabel():
	$AmmoLabel.text = str(ammoCurrent) + "/"+ str(ammoMax)
	$ProgressBar.min_value = 0; $ProgressBar.max_value = ammoMax
	
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
