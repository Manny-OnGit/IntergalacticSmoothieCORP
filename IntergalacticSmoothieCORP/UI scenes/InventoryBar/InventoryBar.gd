extends NinePatchRect

onready var to_storage_slot = get_node("MarginContainer/HBoxContainer/TheTrashBox")
onready var spr = preload("res://misc/Sprite.tscn")
func _physics_process(delta):
	if to_storage_slot.has_item():
		var y = spr.instance()
		self.add_child(y)
		y.global_position = $MarginContainer/HBoxContainer/TheTrashBox.rect_global_position + Vector2(10,10)
		y.texture = to_storage_slot.item.texture
		$Tween.interpolate_property(y,"scale",Vector2(1,1),Vector2(0,0),1,Tween.TRANS_LINEAR,Tween.EASE_OUT_IN)
		$Tween.start()
		
		
		if to_storage_slot.item.extra_texture != null:
			Global.play_sound("res://StephenAssets/Sounds/Error5.wav")
			var x = spr.instance()
			self.add_child(x)
			x.global_position = $MarginContainer/HBoxContainer/TheTrashBox.rect_global_position + Vector2(10,10)
			x.texture = to_storage_slot.item.extra_texture
			$Tween.interpolate_property(x,"scale",Vector2(1,1),Vector2(0,0),1,Tween.TRANS_LINEAR,Tween.EASE_OUT_IN)
			$Tween.start()
			pass
		

		
		Global.play_sound("res://StephenAssets/Sounds/Error5.wav")
		Global.StorageScene.add_item_to_storage(to_storage_slot.remove_item())
		
	pass


func _on_Tween_tween_completed(object, key):
	object.queue_free()
	pass # Replace with function body.
