extends NinePatchRect
#this will take two ingredients and make them into one ingredient
onready var left_slot = $MarginContainer/VBoxContainer/InputLayer/LeftSlot
onready var right_slot = $MarginContainer/VBoxContainer/InputLayer/RightSlot
onready var button = $MarginContainer/VBoxContainer/InputLayer/VBoxContainer/CombineButton
onready var text_bar = $MarginContainer/VBoxContainer/InputLayer/VBoxContainer/TextureProgress
onready var result_slot = $MarginContainer/VBoxContainer/ResultLayer/ResultSlot

func _ready():
	pass
func _physics_process(delta):
	check_valididity()
func _on_CombineButton_pressed():
	Global.play_sound("res://StephenAssets/Sounds/GenericButton5.wav")
	text_bar.value += 1
	if text_bar.max_value == text_bar.value:
		create_combo_item(left_slot.remove_item(),right_slot.remove_item())
		text_bar.value = 0
		pass
	
	pass # Replace with function body.
func create_combo_item(left_item :item,right_item : item):
	var temp = [str(left_item.item_name),str(right_item.item_name)]
	var new_name = ""
	if temp[0] < temp[1]:
		new_name = temp[0]+temp[1]
	else:
		new_name = temp[1]+temp[0]
		var swap_hold = temp[0]
		temp[0]=temp[1]
		temp[1]=swap_hold
	result_slot.add_item(item.new(Global.ingredient_dictionary[temp[0]][0],new_name,{},Global.ingredient_dictionary[temp[1]][0]))
	Global.play_sound("res://StephenAssets/Sounds/Success7a.wav")
	
func _on_LeftSlot_item_added(_item):
	check_valididity()
	pass # Replace with function body.


func _on_RightSlot_item_added(_item):
	check_valididity()
	pass # Replace with function body.

func check_valididity() -> bool: #checks both
	
	if right_slot.item == null or left_slot.item == null or result_slot.item != null:
		button.disabled = true
		return false
	if right_slot.peek_item_name() == left_slot.peek_item_name():
		button.disabled = true
		return false
	if right_slot.basic_ingredient() and left_slot.basic_ingredient():
		button.disabled = false
		return true
	button.disabled = true
	return false

