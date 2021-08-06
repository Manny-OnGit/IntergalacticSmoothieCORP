extends Node2D
class_name item

export(Texture) var texture 
export(Texture) var extra_texture
export var item_name = ""

var smoothie_ingredients = {}

func valid_object():
	if texture == null or item_name == "":
		return false;
	return true;

func _init(_texture_path, _item_name, _smoothie_dict := {},_extra_texture := ""):
	self.texture = load(_texture_path)
	self.item_name = str(_item_name)
	self.smoothie_ingredients = _smoothie_dict
	if _extra_texture != "":
		print("extra texture loaded")
		self.extra_texture = load(_extra_texture)
