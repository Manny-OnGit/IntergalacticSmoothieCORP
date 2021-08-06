extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var item = null;
var item_count = 0;

signal item_removed
signal item_added
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


func add_item(_item):
	if _item.valid_object():
		if self.item == null: #if we have no item
			get_node("NinePatchRect/TextureRect").texture = _item.texture
			if _item.extra_texture != null:
				$NinePatchRect/OptionalTexture.texture = _item.extra_texture
			self.item_count += 1;
			refresh_label()
			item = _item
			emit_signal("item_added",_item)
			return true
		if self.item.item_name == _item.item_name: # are we adding duplicate item
			self.item_count += 1
			refresh_label()
			emit_signal("item_added",_item)
			return true
		if self.item.item_name != _item.item_name:
			return false
			
func remove_item():
	var temp
	if self.item == null: #there is already no item
		emit_signal("item_removed")
		return null
	emit_signal("item_removed",temp)
	if self.item_count > 0: #we remove the item
		temp = self.item
		self.item_count -= 1
		refresh_label()
		#now we check if there is any item left
		if self.item_count == 0:
			self.item = null
			get_node("NinePatchRect/TextureRect").texture = null
			get_node("NinePatchRect/OptionalTexture").texture = null
	return temp
			
func has_item():
	if item == null:
		return false
	return true
func basic_ingredient()->bool:
	if self.peek_item() == null:
		return false
	var temp = self.peek_item()
	for ingredient in Global.ingredient_dictionary:
		if temp.item_name == ingredient and temp.item_name != "SMOOTHIE":
			return true
	return false
func peek_item_name():
	return item.item_name
func peek_item():
	return self.item
func move_slot(_destination):#this is a function that will trade the slots both source and slot or a node type of itemslot
	if self.item == null or (_destination.item != null and _destination.item != self.item): #if this item slot has an item, and the destination does not
		return false
	var x = remove_item()
	_destination.add_item(x)
	return true

func refresh_label():
	if self.item_count <= 1:
		$NinePatchRect/Label.text = ""
		return
	$NinePatchRect/Label.text = str(self.item_count)
	
