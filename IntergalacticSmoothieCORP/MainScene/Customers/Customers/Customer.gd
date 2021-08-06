extends Node2D

var order = {}
var seconds_since_arrival = 0
var counter = 0
var oneShot = false
var money_to_pay = 0

var floati_funni_list = ["res://StephenAssets/faces/Angry.png","res://StephenAssets/faces/Happy.png","res://StephenAssets/faces/Meh.png"]
onready var item_slot = get_node("Control/ItemSlot")
onready var combo_texture = preload("res://StephenAssets/misc/chain.png")
onready var floaty_funny = preload("res://MainScene/Customers/CustomerSatisfaction/CustomerSatisfaction.tscn")


signal customer_leaving

func _physics_process(delta):
	if item_slot.has_item():
		check_smoothie(item_slot.remove_item())
	counter+=1
	if counter == 60:
		seconds_since_arrival += 1
		counter = 0
		
		

func _ready(_order := {},combo:= []):
	randomize()
	$AnimationPlayer.play("Arriving")
	$texture.texture = load(Global.cars_directories[randi() % Global.cars_directories.size()])
	var order_ingredients = get_node("Control/MarginContainer/OrderIngredients")
	if combo == []:
		order = _order.duplicate(true)
	if combo.size() >= 1:
		for x in combo: #we have rid of the combo item
			#_order.erase(x)
			var combo_item = ""
			if combo[0] < combo[1]:
				combo_item = combo[0]+combo[1]
			else:
				combo_item = combo[1]+combo[0]
			order[combo_item] = 1
		#insert the combo making thing here
	var i = 0
	for key in _order:
		if i == 4:
			break
		for j in range(_order[key]): #add x times
			money_to_pay += 8
			order_ingredients.get_child(i).get_node("ItemSlot").add_item(Global.create_ingredient(key))
		if combo.has(key) and combo != []:
			order_ingredients.get_child(i).get_node("ItemSlot/NinePatchRect/OptionalTexture").texture = combo_texture
		i += 1
		
func check_smoothie(_smoothie):
	print("customer wants " + str(order))
	print("you gave " + str(_smoothie.smoothie_ingredients))
	if oneShot == true:
		return
	oneShot = true
	var temp = Global.areDictsEqual(order,_smoothie.smoothie_ingredients)
	if temp == true: #successful order get paid
		Global.add_score(50)
		if seconds_since_arrival < 45:
			money_to_pay = int(money_to_pay * 1.25)#25 percent bonus if happy
			happy()
		else:
			meh()
		Global.add_money(money_to_pay)
	if temp == false:
		if _smoothie.item_name == "SMOOTHIE":
			Global.add_score(15)
		angy()
	$AnimationPlayer.play("Leaving")
	yield($AnimationPlayer,"animation_finished")
	Global.ParkingScene.car_leaving(self)
	self.queue_free()
	
func happy():
	var x = floaty_funny.instance()
	x.get_node("Sprite").texture = load(floati_funni_list[1])
	add_child(x)
	pass
func meh():
	var x = floaty_funny.instance()
	x.get_node("Sprite").texture = load(floati_funni_list[2])
	add_child(x)
	pass
func angy():
	var x = floaty_funny.instance()
	x.get_node("Sprite").texture = load(floati_funni_list[0])
	#x.position = self.position
	x.z_index = 30
	add_child(x)
	
	
func _on_ItemSlot_item_added(_item):
	check_smoothie(_item)
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Arriving":
		$AnimationPlayer.play("Idle")
	pass # Replace with function body.
