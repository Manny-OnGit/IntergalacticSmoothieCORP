extends NinePatchRect

onready var ItemSlot = get_node("MarginContainer/Body/ItemContainer")

func _ready():
	Global.StorageScene = self
	for x in range(5):
		for key in Global.ingredient_dictionary:
			if key != "SMOOTHIE":
				add_item_to_storage(Global.create_ingredient(key))
			
func add_item_to_storage(_input_item : item):
	for slot in ItemSlot.get_children():
		if slot.has_item():
			if slot.peek_item().item_name == _input_item.item_name:
				slot.add_item(_input_item)
				return
	for slot in ItemSlot.get_children():
		if slot.has_item() == false:
			slot.add_item(_input_item)
			return
		#var temp = 
		#if temp == true:
			#reak
