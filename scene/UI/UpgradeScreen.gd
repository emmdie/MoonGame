extends ColorRect
signal upgrade(cartIndex, upgradeIndex)
var cart
var upgrade

func _ready():
	get_tree().paused = true
	
func upgrade():
	emit_signal("upgrade", cart, upgrade)
	get_tree().paused = false
	queue_free()

func _on_CartButon_item_selected(index):
	cart = index
	print("Upgrade Screen cart = " + str(cart))

func _on_confirmButton_pressed():
	print("Confirm Button: upgrade= " + str(upgrade)+ " cart= "+ str(cart))
	if(cart == null || upgrade == null || cart == -1 || upgrade == -1):
		pass
	else:
		upgrade()

func _on_UpgradeButton_item_selected(index):
	upgrade = index
	print("Upgrade Screen upgrade = " + str(upgrade))
