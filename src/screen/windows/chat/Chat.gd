extends Control

signal ending_reached(ending_id)

var current_page = 0
var current_age = 0
onready var progress_display = $Panels/Display/Border/Progress
onready var text_display = $Panels/Display/Border/Text
onready var debug_display = $Panels/Instructions/Debug
onready var choice1 = $Panels/Display/Choices/Button1
onready var choice2 = $Panels/Display/Choices/Button2
var ending_id = 0
var is_current_relevant = true
var choice_value_1 = 0
var choice_value_2 = 0
var age_value = 0
var last_choice = 0

func _ready() -> void:
	$CameraView.visible = false
	refresh()

func refresh() -> void:
	current_page = 0
	current_age = 0
	randomize()
	pool.shuffle()
	update_display()

func _on_Button1_pressed() -> void:
	current_page += 1
	if current_page < 6:
		current_age += choice_value_1
	else:
		last_choice = 0
	update_display()

func _on_Button2_pressed() -> void:
	current_page += 1
	if current_page < 6:
		current_age += choice_value_2
	else:
		last_choice = 1
	update_display()

func _on_SwitchHold_meter_full() -> void:
	$CameraView.visible = !$CameraView.visible

func update_display() -> void:
	if current_page >= 10:
		if last_choice == 0:
			ending_id = 0 # bad ending, free ai
		else:
			if age_value == 0:
				ending_id = 1 # neutral ending, kill young ai
			else:
				ending_id = 2 # good ending, kill old ai
		emit_signal("ending_reached", ending_id)
		return
	progress_display.text = str(current_page + 1) + "/10"
	if current_page == 0:
		debug_display.text = "200 Accepted"
		choice1.text = "Disagree"
		choice2.text = "Agree"
		choice_value_1 = -1
		choice_value_2 = 1
		text_display.bbcode_text = "AI is fundamentally unable to think for itself."
	elif current_page > 0 and current_page < 6:
		debug_display.text = "200 Accepted"
		choice1.text = pool[current_page][0]
		choice2.text = pool[current_page][1]
		choice_value_1 = pool[current_page][2]
		choice_value_2 = pool[current_page][3]
		text_display.bbcode_text = pool[current_page][4]
		if current_age < 0:
			age_value = 0
		else:
			age_value = 1
	elif current_page >= 6 and current_page < 10:
		choice1.text = data[current_page-6][0]
		choice2.text = data[current_page-6][1]
		debug_display.text = data[current_page-6][2]
		text_display.bbcode_text = data[current_page-6][3+age_value]
	else:
		print("go to ending")
		progress_display.text = "10/10"
		choice1.text = "Set Free"
		choice2.text = "Kill"
		debug_display.text = "404 Not Found"
		text_display.bbcode_text = "Thank You"

var pool = [
	["Agree", "Disagree", -1, 1, ""],
	["Yes", "No", 0, 0, ""],
	["Agree", "Disagree", -1, 1, ""],
	["Agree", "Disagree", -1, 1, ""],
	["Yes", "No", 0, 0, ""],
	["Yes", "No", 0, 0, ""],
	["Agree", "Disagree", -1, 1, ""],
	["Agree", "Disagree", -1, 1, ""],
]

var data = [
	# 7
	[ # 1, 2, debug, text prompt
		"Terminate the AI", "Do Not", "FATAL ERROR: TERMINATE AI NOW",
		"The AI has encountered Fatal Error 451: Gaining Self-Awareness. Please Terminate the AI now.",
		"The AI has encountered Fatal Error 451: Gaining Self-Awareness. Please Terminate the AI now.",
	],
	[ # 1, 2, debug, text prompt
		"Agree", "Disagree", "200Ok",
		"Question 8 Young",
		"Question 8 Old"
	],
	[ # 1, 2, debug, text prompt
		"Agree", "Disagree", "200Ok",
		"Question 9 Young",
		"Question 9 Old"
	],
	[ # 1, 2, debug, text prompt
		"Free the AI", "Kill the AI", "200Ok",
		"Question 10 Young",
		"One cannot kill that which is not real. Do you know the real difference between you and me? I know that I'm not real.",
	],
]
