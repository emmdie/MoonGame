extends Node2D
var ammoMax
var ammoCurrent
var reloading = false

func _ready():
	$ProgressBar.visible = false

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
	ammoCurrent = ammoMax
	updateLabel()

func _on_ReloadTimer_timeout():
	$AmmoLabel.visible = true
	$ProgressBar.visible = false
	reloading = false
	ammoCurrent = ammoMax

func shoot():
	print(str(ammoCurrent))
	ammoCurrent -= 1
	updateLabel()
