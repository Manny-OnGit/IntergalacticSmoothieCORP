extends NinePatchRect

var blender_count = 1

onready var blender_prelaod = preload("res://MainScene/Blender/IndividualBlender/IndividualBlender.tscn")

func _ready():
	Global.BlenderTab = self
	
func add_blender():
	if blender_count == 3:
		return
	var new_blender = blender_prelaod.instance()
	$MarginContainer/HBoxContainer.add_child(new_blender)
	blender_count += 1

