extends Control

var current_page = 0
onready var progress_display = $Panels/Display/Border/Progress
onready var text_display = $Panels/Display/Border/Text
onready var debug_display = $Panels/Instructions/Debug
onready var choice1 = $Panels/Display/Choices/Button1
onready var choice2 = $Panels/Display/Choices/Button2
var ending_id = 0
signal ending_reached(ending_id)

func _ready() -> void:
	$CameraView.visible = false
	update_display()

func _on_Button1_pressed() -> void:
	current_page += 1
	update_display()

func _on_Button2_pressed() -> void:
	current_page += 1
	update_display()

func _on_SwitchHold_meter_full() -> void:
	$CameraView.visible = !$CameraView.visible

func update_display() -> void:
	if current_page >= 10:
		emit_signal("ending_reached", ending_id)
	if current_page < len(data):
		progress_display.text = str(current_page + 1) + "/10"
		choice1.text = data[current_page][0]
		choice2.text = data[current_page][1]
		debug_display.text = data[current_page][2]
		text_display.bbcode_text = data[current_page][3]
	else:
		print("go to ending")
		progress_display.text = "10/10"
		choice1.text = "Set Free"
		choice2.text = "Kill"
		debug_display.text = "404NotFound"
		text_display.bbcode_text = "Thank You"

var data = [
	# 0
	[ # 1, 2, debug, text prompt
		"Agree", "Disagree", "200Ok",
		"Question 1"
	],
	[ # 1, 2, debug, text prompt
		"Agree", "Disagree", "200Ok",
		"Question 2"
	],
	[ # 1, 2, debug, text prompt
		"Agree", "Disagree", "200Ok",
		"Question 3"
	],
	[ # 1, 2, debug, text prompt
		"Agree", "Disagree", "200Ok",
		"Question 4"
	],
	[ # 1, 2, debug, text prompt
		"Agree", "Disagree", "200Ok",
		"Question 5"
	],
	[ # 1, 2, debug, text prompt
		"Agree", "Disagree", "200Ok",
		"Question 6"
	],
	[ # 1, 2, debug, text prompt
		"Agree", "Disagree", "200Ok",
		"Question 7"
	],
	[ # 1, 2, debug, text prompt
		"Agree", "Disagree", "200Ok",
		"Question 8"
	],
	[ # 1, 2, debug, text prompt
		"Agree", "Disagree", "200Ok",
		"Question 9"
	],
	[ # 1, 2, debug, text prompt
		"Agree", "Disagree", "200Ok",
		"Question 10"
	],
]
