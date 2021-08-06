extends Node2D

func _ready():
	var x = Global.create_ingredient("BUG")#Global.create_ingredient("BUG")
	
	Global.StorageScene.add_item_to_storage(x)
	for key in Global.ingredient_dictionary:
		Global.StorageScene.add_item_to_storage(Global.create_ingredient(key))
