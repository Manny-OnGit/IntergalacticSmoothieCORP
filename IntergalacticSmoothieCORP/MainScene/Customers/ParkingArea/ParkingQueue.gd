extends Node2D

var car_queue = [null,null,null,null]
var car_count = 0 #max car count allowed is 4
var advert_count = 0


onready var parking_spots = get_node("ParkingSpots")
onready var customers = get_node("Customers")
onready var preload_customer = preload("res://MainScene/Customers/Customers/Customer.tscn")

var parking_maximum = 2
func _physics_process(delta):
	pass
func _ready():
	Global.ParkingScene = self
	var minute = 0
	delay_call(0,"dictionary_easy")
	delay_call(30,"dictionary_easy")
	delay_call(0,"dictionary_easy",1)
	delay_call(30,"dictionary_easy",1)
	delay_call(0,"dictionary_easy",2)
	delay_call(30,"dictionary_easy",2)
	delay_call(0,"dictionary_easy",3)
	delay_call(30,"dictionary_easy",3)
	delay_call(0,"dictionary_easy",4)
	delay_call(30,"dictionary_easy",4)
	
	
func purchase_ads():
	advert_count += 1
	pass
func delay_call(time := 20, function := "generate_order_dictionary_easy", minute:=0):
	yield(get_tree().create_timer(time+ (minute*60)),"timeout")
	call(function)

func add_car(order : Dictionary, combo := []):
	if car_count == parking_maximum:
		return
	var customer = preload_customer.instance()
	customer.visible = false
	customers.add_child(customer)
	customer._ready(order, combo)
	customer.global_position = next_avaiable_position().global_position + Vector2(0,-15)
	car_queue[next_available_index()] = customer
	customer.connect("customer_leaving",self,"car_leaving")
	car_queue[car_count] = customer
	car_count += 1
	yield(get_tree().create_timer(.1),"timeout")
	customer.visible = true
	
func unique_ingredient(ban_list : Array):
	var x
	while(true):
		x = Global.random_raw_ingredient()
		if ban_list.has(x):
			continue
		ban_list.append(x)
		return(x)
	pass
func rand_int(low,high):
	return randi()%low+high
func dictionary_easy():
	randomize()
	var x = randi()%2+1
	var return_dict = {}
	var already_used = []
	if x == 1:
		return_dict[unique_ingredient(already_used)] = rand_int(2,3)
		return_dict[unique_ingredient(already_used)] = rand_int(1,2)
	if x == 2:
		return_dict[unique_ingredient(already_used)] = rand_int(2,1)
		return_dict[unique_ingredient(already_used)] = rand_int(1,1)
		return_dict[unique_ingredient(already_used)] = rand_int(1,1)
	add_car(return_dict)
	
func dictionary_easy_combo():
	randomize()
	var return_dict = {}
	var already_used = []
	return_dict[unique_ingredient(already_used)] = rand_int(1,1)
	return_dict[unique_ingredient(already_used)] = rand_int(1,1)
	add_car(return_dict,already_used)

func dictionary_medium():
	randomize()
	var return_dict = {}
	var already_used = []
	var x = rand_int(1,2)
	if x == 1:
		return_dict[unique_ingredient(already_used)] = rand_int(2,3)
		return_dict[unique_ingredient(already_used)] = rand_int(2,3)
		return_dict[unique_ingredient(already_used)] = rand_int(1,2)
	if x == 2:
		return_dict[unique_ingredient(already_used)] = rand_int(2,3)
		return_dict[unique_ingredient(already_used)] = rand_int(2,3)
		return_dict[unique_ingredient(already_used)] = rand_int(1,1)
		return_dict[unique_ingredient(already_used)] = rand_int(1,1)
	add_car(return_dict)
func dictionary_medium_combo():
	randomize()
	var return_dict = {}
	var already_used = []
	var combo_list
	return_dict[unique_ingredient(already_used)] = rand_int(1,1)
	return_dict[unique_ingredient(already_used)] = rand_int(1,1)
	combo_list = already_used.duplicate(true)
	return_dict[unique_ingredient(already_used)] = rand_int(2,3)
	add_car(return_dict,combo_list)
func dictionary_hard():
	randomize()
	var return_dict = {}
	var already_used = []
	var x = rand_int(1,3)
	if x == 1:
		return_dict[unique_ingredient(already_used)] = rand_int(3,5)
		return_dict[unique_ingredient(already_used)] = rand_int(3,5)
		return_dict[unique_ingredient(already_used)] = rand_int(3,5)
	if x == 2:
		return_dict[unique_ingredient(already_used)] = rand_int(3,4)
		return_dict[unique_ingredient(already_used)] = rand_int(2,3)
		return_dict[unique_ingredient(already_used)] = rand_int(2,3)
		return_dict[unique_ingredient(already_used)] = rand_int(1,2)
	if x == 3:
		return_dict[unique_ingredient(already_used)] = rand_int(2,3)
		return_dict[unique_ingredient(already_used)] = rand_int(2,3)
		return_dict[unique_ingredient(already_used)] = rand_int(2,3)
		return_dict[unique_ingredient(already_used)] = rand_int(2,3)
	add_car(return_dict)

func hard_combo():
	randomize()
	var return_dict = {}
	var already_used = []
	var combo_list
	var x = rand_int(1,2)
	if x ==1:
		return_dict[unique_ingredient(already_used)] = rand_int(1,1)
		return_dict[unique_ingredient(already_used)] = rand_int(1,1)
		combo_list = already_used.duplicate(true)
		return_dict[unique_ingredient(already_used)] = rand_int(2,3)
		return_dict[unique_ingredient(already_used)] = rand_int(2,3)
	if x == 2:
		return_dict[unique_ingredient(already_used)] = rand_int(1,1)
		return_dict[unique_ingredient(already_used)] = rand_int(1,1)
		combo_list = already_used.duplicate(true)
		return_dict[unique_ingredient(already_used)] = rand_int(3,4)
		return_dict[unique_ingredient(already_used)] = rand_int(1,1)
	add_car(return_dict,combo_list)
	
func next_avaiable_position():
	var i = 0
	for x in car_queue:
		if x == null:
			break
		i += 1
	return parking_spots.get_child(i)
func next_available_index():
	var i = 0
	for x in car_queue:
		if x == null:
			break
		i += 1
	return i
func add_parking_spot():
	if parking_maximum == 4:
		return
	parking_spots.get_child(parking_maximum).visible = true
	parking_maximum += 1
func car_leaving(customer):
	var customer_list_id = car_queue.rfind(customer)
	#customer.queue_free()
	car_count -= 1
	car_queue[customer_list_id] = null
	for x in range(customer_list_id,parking_maximum):
		if car_queue[x] != null:
			car_queue[x].global_position = next_avaiable_position().global_position + Vector2(0,-15)
			car_queue[x-1] = car_queue[x]
			car_queue[x] = null
	
	
func _on_Timer_timeout():
	if advert_count > 0:
		dictionary_easy_combo()
		advert_count -= 1
	pass # Replace with function body.
