extends Node2D

onready var mouse_cast = get_node("mouse_cast")
onready var item_slot = get_node("ItemSlot")
onready var sprite = $AnimatedSprite
var item_original_location = null

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
func _physics_process(delta):
	self.global_position = get_global_mouse_position()
	get_input()

func get_input():
	if Input.is_action_just_pressed("mouse_click"):
		$AnimatedSprite.animation = "Close"
		
		mouse_cast.force_raycast_update()
		item_original_location = mouse_cast.get_collider()
		if item_original_location == null:
			return
		if item_original_location.is_in_group("ItemSlot"):
			Global.play_sound("res://StephenAssets/Sounds/Popup1.wav")
			item_original_location.get_parent().move_slot(self.get_node("ItemSlot"))
			item_original_location = item_original_location.get_parent()
			
			
	if Input.is_action_just_released("mouse_click"):
		$AnimatedSprite.animation = "Open"
	if Input.is_action_just_released("mouse_click") and item_slot.has_item():
		Global.play_sound("res://StephenAssets/Sounds/Popup2.wav")
		mouse_cast.force_raycast_update()
		var temp = mouse_cast.get_collider() #right now temp is the area
		if temp == null: # if when we release we have not clicked on a box
			if item_original_location != null and item_slot.item != null:
				item_original_location.add_item(item_slot.item)
				item_slot.remove_item()
		#place in the new box
		
		if temp != null:
			temp = temp.get_parent() # it is now the item slot
			var x = item_slot.move_slot(temp)
			if x == false:
				item_original_location.add_item(item_slot.item)
				if item_slot.has_item():
					item_slot.remove_item()
		item_original_location = null
#		if temp != null:
#			temp = temp.get_parent()
#			if item_slot.move_slot(temp):#this has side affect of moving
#				return
#		#temp is either null, or the move failed
#			if item_slot.item != null:
#				item_original_location.add_item(item_slot.item)
#				item_slot.remove_item()
		
		#we will attempt to place the item down, if it is invalid -> return to the original location else place
		
	
