extends Node

var money_clock_ui = null
var player_money = 0
var minutes = 4
var seconds = 59
var seconds_60 = 0
var score = 0
var this_high_score = 0

var over = false

func add_money(amount: int, position := Vector2(0,0)):
	player_money += amount
	
func play_sound(path : String, _pitch := 1.0, _volume_modifier := 0):
	var x = AudioStreamPlayer.new()
	x.stream = load(path)
	x.pitch_scale = _pitch
	x.volume_db = _volume_modifier
	self.add_child(x)
	x.play(0)
	yield(get_tree().create_timer(x.stream.get_length()),"timeout")
	x.queue_free()
	
	
func _ready():
	var x = AudioStreamPlayer.new()
	x.stream = load("res://StephenAssets/Sounds/chillout-cafe-4176.mp3")
	x.volume_db = -10
	self.add_child(x)
	x.play(0)
	
func add_score(value):
	score += value
	
func _physics_process(delta):
	seconds_60 += 1
	if seconds_60 == 60:
		seconds_60 = 0
		seconds -= 1
		if seconds == 0:
			seconds = 59
			minutes -= 1
			if minutes == -1:
				finish_game()
	if money_clock_ui != null:
		update_ui()

func update_ui():
	if over == true:
		return
	money_clock_ui.money_label.set_text(str(minutes)+ ": " +str(seconds)) 
	money_clock_ui.timer_label.set_text(str(player_money))
	pass
	
var main_camera = null
var final_slide = null
func finish_game():
	over = true
	main_camera.cam_tween.interpolate_property(main_camera,"global_position",main_camera.global_position, Vector2(400,200),2,Tween.TRANS_LINEAR,Tween.EASE_IN)
	main_camera.cam_tween.start()
	main_camera.visible = false
	final_slide.fill_values()
	pass

var ingredient_dictionary = {
	"BUG" : ["res://Ingredients/Bugs.png", "BUG"],
	"CO2" : ["res://Ingredients/Carbon dioxide.png", "CO2"],
	"MELON" : ["res://Ingredients/Melon.png","MELON"],
	"MILK" : ["res://Ingredients/Milk.png", "MILK"],
	"PP" : ["res://Ingredients/Protein Powder.png", "PP"],
	"ROCK" : ["res://Ingredients/Rock.png","ROCK"],
	"STAR" : ["res://Ingredients/Stardust.png","STAR"],
	"SMOOTHIE" : ["res://Ingredients/Smoothie.png","SMOOTHIE"]
	}
var raw_ingredient_dictionary = {
	"BUG" : ["res://Ingredients/Bugs.png", "BUG"],
	"CO2" : ["res://Ingredients/Carbon dioxide.png", "CO2"],
	"MELON" : ["res://Ingredients/Melon.png","MELON"],
	"MILK" : ["res://Ingredients/Milk.png", "MILK"],
	"PP" : ["res://Ingredients/Protein Powder.png", "PP"],
	"ROCK" : ["res://Ingredients/Rock.png","ROCK"],
	"STAR" : ["res://Ingredients/Stardust.png","STAR"],
	}
var cars_directories = [
	"res://StephenAssets/cars/Dolorean2.png",
	"res://StephenAssets/cars/Dolorean.png",
	"res://StephenAssets/cars/Plane2.png",
	"res://StephenAssets/cars/Plane.png",
	"res://StephenAssets/cars/Rocket2.png",
	"res://StephenAssets/cars/Rocket.png",
	"res://StephenAssets/cars/Submarine2.png",
	"res://StephenAssets/cars/Submarine.png",
	"res://StephenAssets/cars/UFO2.png",
	"res://StephenAssets/cars/UFO.png"
]
func create_ingredient(ingredient, smoothie_dict := {}):
	var value = ingredient_dictionary[ingredient]
	if value == null:
		return
	if ingredient == "SMOOTHIE":
		return item.new(value[0],value[1],smoothie_dict)
	return item.new(value[0],value[1])
	
var StorageScene = null
var BlenderTab = null
var ParkingScene = null
var ScoreCounter = null

func random_raw_ingredient() -> String:
	return get_random_key(raw_ingredient_dictionary)


func areDictsEqual(a: Dictionary, b: Dictionary) -> bool: #credit goes to reddit user kleonc for this function
	if not a or not b:
		return false
	if a.size() != b.size():
		return false
	for key in a.keys():
		if not b.has(key):
			return false
		if a[key] != b[key]:
			return false
	return true
func get_random_key(dict: Dictionary): #credit goes to reddit user Armanlex for this function
	var a = dict.keys()
	a = a[randi() % a.size()]
	return a
	
