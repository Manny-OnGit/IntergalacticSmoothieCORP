extends NinePatchRect


func _ready():
	Global.final_slide = self
	
func fill_values():
	$MarginContainer/VBoxContainer/Points/Label2.text = str(Global.score)
	$MarginContainer/VBoxContainer/Money/MoneyAmount.text = str(Global.player_money)
	$MarginContainer/VBoxContainer/Money/MoneyScoreAmount.text = str(Global.player_money * 5)
	$MarginContainer/VBoxContainer/FinalScore/FinalFinalScore.text = str(Global.player_money * 5 + Global.score)
	if (Global.player_money * 5 + Global.score) > Global.this_high_score:
		Global.this_high_score = Global.player_money * 5 + Global.score
		


func _on_TextureButton_pressed():
	get_tree().change_scene("res://MainScene/MainMenu/MainMenu.tscn")
	pass # Replace with function body.
