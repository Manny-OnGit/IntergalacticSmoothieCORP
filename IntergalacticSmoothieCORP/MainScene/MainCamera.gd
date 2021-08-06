extends Camera2D

var centered = true
var interactable = true
var moved = Vector2(0,0)
onready var cam_tween = $Tween

func _ready():
	Global.main_camera = self
	
func _on_Left_pressed():
	move_cam(Vector2(-320,0))
	pass # Replace with function body.


func _on_Right_pressed():
	move_cam(Vector2(320,0))
	pass # Replace with function body.

func _on_Down_pressed():
	move_cam(Vector2(0,180))
	pass # Replace with function body.


func _on_Up_pressed():
	move_cam(Vector2(0,-180))
	pass # Replace with function body.
	
func move_cam(vector : Vector2):
	if centered == true and interactable == true:
		centered = false
		moved = vector
		$Tween.interpolate_property(self,"global_position",self.global_position,vector ,.3,Tween.TRANS_LINEAR,Tween.EASE_IN)
		$Tween.start()
		interactable = false
		if vector == Vector2(0,180):
			$Control/InventoryBar.rect_position = Vector2(0,200)
			
		interactable = true
	else:
		center_self()
		$Control/InventoryBar.rect_position = Vector2(170,140)

func center_self():
	centered = true
	$Tween.interpolate_property(self,"position",self.global_position,Vector2(0,0),.3,Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()
	moved = Vector2(0,0)
	self.global_position = moved

