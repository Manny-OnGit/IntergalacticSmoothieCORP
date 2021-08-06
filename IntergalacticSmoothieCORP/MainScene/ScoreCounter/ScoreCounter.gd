extends NinePatchRect

func _ready():
	Global.ScoreCounter = self

func _physics_process(delta):
	get_node("MarginContainer/VBoxContainer/Label").text = str(Global.score)
