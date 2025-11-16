extends Control
var allItemsToGuess = [ 
"Strawberry", 
"Watermelon", 
"Blueberry",  
"Pineapple",
"Ackee",
"Apple",
"Asparagus",
"Broccoly",
"BuddhasHand",
"Carrot",
"Celtuce",
"Coliflower",
"Cupuau",
"Eggpland",
"HerryTomatoes",
"Jabuticaba",
"MalabarSpinach",
"Mango",
"Mangosteen",
"MiracleFruit",
"Oca",
"Patato",
"Pepper",
"Pineapple",
"Pumpkin",
"Rambutan",
"RedCabbage",
"Salak",
"Samphire",
"VanDurian",]
var remainingItemToGuess = allItemsToGuess.duplicate()


var currentItemToGuess

@onready var button_a: Button = $MarginContainer/VBoxContainer/AnwerButtonContainer/ButtonA
@onready var button_b: Button = $MarginContainer/VBoxContainer/AnwerButtonContainer/ButtonB
@onready var button_c: Button = $MarginContainer/VBoxContainer/AnwerButtonContainer/ButtonC
@onready var button_d: Button = $MarginContainer/VBoxContainer/AnwerButtonContainer/ButtonD

@onready var guess_item_image: TextureRect = $MarginContainer/VBoxContainer/GuessItemImage

@onready var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer


@onready var correct: Label = $MarginContainer/VBoxContainer/GuessResult/Correct
@onready var wrong: Label = $MarginContainer/VBoxContainer/GuessResult/Wrong

@onready var timer: Timer = $MarginContainer/TimerRemaining/Timer
@onready var timer_remaining: Label = $MarginContainer/TimerRemaining


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setNewItemToGuess()
	

func _process(delta: float) -> void:
	timer_remaining.text = str(timer.time_left)


func setNewItemToGuess():
	
	if remainingItemToGuess.is_empty():
		get_tree().change_scene_to_file("res://game_over.tscn")
		
	else:
		currentItemToGuess = remainingItemToGuess[randi() % remainingItemToGuess.size()]
		setAnswerButtonText()
		
		var image_path = "res://assets/images/" + currentItemToGuess +".png"
		var texture = load(image_path)
		# Assign the texture
		guess_item_image.texture = texture


	remainingItemToGuess.erase(currentItemToGuess)
	print(remainingItemToGuess)
	
func setAnswerButtonText():
	correct.set_visible(false)
	wrong.set_visible(false)
	var buttonAnswr = [currentItemToGuess]
	
	while buttonAnswr.size() < 4:
		print(allItemsToGuess)
		print(remainingItemToGuess)
		var newAnswerToAdd = allItemsToGuess[randi() % allItemsToGuess.size()]
		if buttonAnswr.find(newAnswerToAdd) == -1:
			buttonAnswr.append(newAnswerToAdd)
	
	buttonAnswr.shuffle()
	
	button_a.text = buttonAnswr[0]
	button_b.text = buttonAnswr[1]
	button_c.text = buttonAnswr[2]
	button_d.text = buttonAnswr[3]

func _on_set_new_item_pressed() -> void:
	setNewItemToGuess()


func _on_restart_game_button_pressed() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.
	
	
func _on_guess_pressed(button: Button):
	if button.text == currentItemToGuess:
		print("Correct")
		correct.set_visible(true)
		wrong.set_visible(false)
	else:
		print("Incorrect")
		correct.set_visible(false)
		wrong.set_visible(true)
	


func _on_timer_timeout() -> void:
	print("Timer Done") # Replace with function body.

func ensure_node_exists(path: String, timeout := 2.0) -> void:
	var elapsed := 0.0
	while not has_node(path) and elapsed < timeout:
		await get_tree().process_frame
		elapsed += get_process_delta_time()
