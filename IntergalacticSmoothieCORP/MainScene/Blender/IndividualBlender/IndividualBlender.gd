extends NinePatchRect


onready var item_slot = $MarginContainer/HBoxContainer/Left/ItemSlot
onready var progress_bar = $MarginContainer/HBoxContainer/Left/TextureProgress
onready var start_sound = preload("res://StephenAssets/Sounds/blender start.wav")
onready var loop_sound = preload("res://StephenAssets/Sounds/blender loop.wav")
onready var end_sound = preload("res://StephenAssets/Sounds/blender stop.wav")
#this is where the blender logic is 60 is one second
var random_color = ["aliceblue", "aquamarine", "cyan", "darkred", "firebrick", "honeydew", "lavender","lime","pink"]
var active = false
var blender_time_max = 180
var custom_timer = 0

var item_list = {}
signal timer_complete


func _physics_process(delta):
	if item_slot.has_item() and item_slot.peek_item().item_name != "SMOOTHIE":
		add_to_blender(item_slot.remove_item())
	if self.active == true:
		progress_bar.value = custom_timer
		progress_bar.max_value = blender_time_max
		custom_timer += 1
		if custom_timer >= blender_time_max:
			emit_signal("timer_complete")
	
func add_to_blender(_item):
	if _item != null and _item.item_name != "SMOOTHIE":
		if self.active == false:
			self.active = true
			blender_start()
			$MarginContainer/HBoxContainer/VBoxContainer/MarginContainer/TextureButton.disabled = false
			#$MarginContainer/HBoxContainer/VBoxContainer/TextureRect/AnimatedSprite.self_modulate = Color(random_color[randi()%random_color.size()])
			$AnimationPlayer.play("StartAnimation")
			blender_time_max = 180
			custom_timer = 0
		blender_time_max += 120
		if item_list.has(_item.item_name) == false:
			item_list[_item.item_name] = 1
		else:
			item_list[_item.item_name] += 1

func blender_start():
	$AudioStreamPlayer.stream = start_sound
	$AudioStreamPlayer.play()
	yield(get_tree().create_timer(start_sound.get_length()),"timeout")
	$AudioStreamPlayer.stream = loop_sound
	while(active == true):
		$AudioStreamPlayer.play()
		yield(get_tree().create_timer(loop_sound.get_length()),"timeout")
	pass
func blender_end():
	$AudioStreamPlayer.stream = end_sound
	$AudioStreamPlayer.play()
	yield(get_tree().create_timer(end_sound.get_length()),"timeout")
	$AudioStreamPlayer.stop()
	pass

func _on_IndividualBlender_timer_complete():
	blender_end()
	$AnimationPlayer.play("EndAnimation")
	var temp = Global.create_ingredient("SMOOTHIE",item_list) #smoothie created
	temp.smoothie_ingredients = item_list.duplicate()
	item_slot.add_item(temp)
	# reset all the things here:
	active = false
	$MarginContainer/HBoxContainer/VBoxContainer/MarginContainer/TextureButton.disabled = true
	blender_time_max = 180
	custom_timer = 0
	progress_bar.value = 0
	item_list.clear()
	Global.play_sound("res://StephenAssets/Sounds/Success4.wav")
	pass # Replace with function body.


func _on_TextureButton_pressed():
	Global.play_sound("res://StephenAssets/Sounds/GenericButton5.wav")
	custom_timer += 60
	pass # Replace with function body.
