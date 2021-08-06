extends NinePatchRect

export (int) var Blender1Price = 50
export (int) var Blender2Price = 50

export (int) var Parking1Price = 25
export (int) var Parking2Price = 25
export (int) var IngredientPrice = 1
onready var ingredient_container = get_node("MarginContainer/EntireShop/PurchaseIngredients/NinePatchRect/MarginContainer/IngredientContainer")


func _on_PurchaseBlender1_pressed():
	if Global.player_money >= Blender1Price:
		Global.add_money(-Blender1Price)
		Global.BlenderTab.add_blender()
		$MarginContainer/EntireShop/BlenderRow/NinePatchRect/MarginContainer/HBoxContainer/PurchaseBlender1.disabled = true
		Global.play_sound("res://StephenAssets/Sounds/Success5.wav")
		
func _on_PurchaseBlender2_pressed():
	if Global.player_money >= Blender2Price:
		Global.add_money(-Blender2Price)
		Global.BlenderTab.add_blender()
		$MarginContainer/EntireShop/BlenderRow/NinePatchRect/MarginContainer/HBoxContainer/PurchaseBlender2.disabled = true
		Global.play_sound("res://StephenAssets/Sounds/Success5.wav")

func _on_PurchaseParking1_pressed():
	if Global.player_money >= Parking1Price:
		Global.add_money(-Parking1Price)
		Global.ParkingScene.add_parking_spot()
		$MarginContainer/EntireShop/ParkingRow/NinePatchRect/MarginContainer/HBoxContainer/PurchaseParking1.disabled = true
		Global.play_sound("res://StephenAssets/Sounds/Success5.wav")

func _on_PurchaseParking2_pressed():
	if Global.player_money >= Parking2Price:
		Global.add_money(-Parking2Price)
		Global.ParkingScene.add_parking_spot()
		$MarginContainer/EntireShop/ParkingRow/NinePatchRect/MarginContainer/HBoxContainer/PurchaseParking2.disabled = true
		Global.play_sound("res://StephenAssets/Sounds/Success5.wav")


func _on_PurchaseItem1_pressed():
	if Global.player_money >= IngredientPrice:
		Global.add_money(-IngredientPrice)
		Global.StorageScene.add_item_to_storage(Global.create_ingredient("BUG"))
		Global.play_sound("res://StephenAssets/Sounds/GenericNotification10a.wav")
func _on_PurchaseItem2_pressed():
	if Global.player_money >= IngredientPrice:
		Global.add_money(-IngredientPrice)
		Global.StorageScene.add_item_to_storage(Global.create_ingredient("CO2"))
		Global.play_sound("res://StephenAssets/Sounds/GenericNotification10a.wav")
func _on_PurchaseItem3_pressed():
	if Global.player_money >= IngredientPrice:
		Global.add_money(-IngredientPrice)
		Global.StorageScene.add_item_to_storage(Global.create_ingredient("MELON"))
		Global.play_sound("res://StephenAssets/Sounds/GenericNotification10a.wav")
func _on_PurchaseItem4_pressed():
	if Global.player_money >= IngredientPrice:
		Global.add_money(-IngredientPrice)
		Global.StorageScene.add_item_to_storage(Global.create_ingredient("MILK"))
		Global.play_sound("res://StephenAssets/Sounds/GenericNotification10a.wav")
func _on_PurchaseItem5_pressed():
	if Global.player_money >= IngredientPrice:
		Global.add_money(-IngredientPrice)
		Global.StorageScene.add_item_to_storage(Global.create_ingredient("PP"))
		Global.play_sound("res://StephenAssets/Sounds/GenericNotification10a.wav")
func _on_PurchaseItem6_pressed():
	if Global.player_money >= IngredientPrice:
		Global.add_money(-IngredientPrice)
		Global.StorageScene.add_item_to_storage(Global.create_ingredient("ROCK"))
		Global.play_sound("res://StephenAssets/Sounds/GenericNotification10a.wav")
	pass # Replace with function body.
func _on_PurchaseItem7_pressed():
	if Global.player_money >= IngredientPrice:
		Global.add_money(-IngredientPrice)
		Global.StorageScene.add_item_to_storage(Global.create_ingredient("STAR"))
		Global.play_sound("res://StephenAssets/Sounds/GenericNotification10a.wav")
	pass # Replace with function body.
func _on_PurchaseAds1_pressed():
	if Global.player_money >= 10:
		Global.add_money(-10)
		Global.ParkingScene.purchase_ads()
		Global.play_sound("res://StephenAssets/Sounds/SciFiNotification2.wav")
	pass # Replace with function body.
