extends Node2D



func _ready():
	$NinePatchRect/MarginContainer/VBoxContainer/Creditsbar/Label2.text = str(Global.this_high_score)
	
func _on_TextureButton_pressed():
	get_tree().change_scene("res://MainScene/Main.tscn")
	
	pass # Replace with function body.
