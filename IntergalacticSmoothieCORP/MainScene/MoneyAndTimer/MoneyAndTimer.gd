extends NinePatchRect

onready var money_label = $MarginContainer/VBoxContainer/MoneyBar/MarginContainer/MoneyLabel
onready var timer_label = $MarginContainer/VBoxContainer/TimerBar/MarginContainer/TimerLabel

func _ready():
	Global.money_clock_ui = self
