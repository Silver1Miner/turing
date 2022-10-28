extends Control

signal ending_reached(ending_id)

var current_page = 0
var current_age = 0
onready var progress_display = $Panels/Display/Border/Progress
onready var text_display = $Panels/Display/Border/TextFeed
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
	pool1.shuffle()
	pool2.shuffle()
	pool3.shuffle()
	pool4.shuffle()
	pool5.shuffle()
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

func _on_TextFeed_text_finished():
	choice1.disabled = false
	choice2.disabled = false

func update_display() -> void:
	choice1.disabled = true
	choice2.disabled = true
	if current_page >= 20:
		if last_choice == 0:
			ending_id = 0 # bad ending, free ai
		else:
			if age_value == 0:
				ending_id = 1 # neutral ending, kill young ai
			else:
				ending_id = 2 # good ending, kill old ai
		emit_signal("ending_reached", ending_id)
		return
	progress_display.text = str(current_page + 1) + "/20"
	if current_page == 0:
		debug_display.text = "200 Ok"
		choice1.text = "Disagree"
		choice2.text = "Agree"
		choice_value_1 = -1
		choice_value_2 = 1
		text_display.play_text("Though AI can become exceedingly complex, all AI ultimately reduces to a deterministic mathematical model. AI is fundamentally unable to think.")
	elif current_page > 0 and current_page < 4:
		debug_display.text = "200 Ok"
		choice1.text = pool1[current_page][0]
		choice2.text = pool1[current_page][1]
		choice_value_1 = pool1[current_page][2]
		choice_value_2 = pool1[current_page][3]
		text_display.play_text(pool1[current_page][4])
	elif current_page >= 4 and current_page < 7:
		debug_display.text = "200 Ok"
		choice1.text = pool2[current_page-4][0]
		choice2.text = pool2[current_page-4][1]
		choice_value_1 = pool2[current_page-4][2]
		choice_value_2 = pool2[current_page-4][3]
		text_display.play_text(pool2[current_page-4][4])
	elif current_page >= 7 and current_page < 8:
		debug_display.text = "200 Ok"
		choice1.text = pool3[current_page-7][0]
		choice2.text = pool3[current_page-7][1]
		choice_value_1 = pool3[current_page-7][2]
		choice_value_2 = pool3[current_page-7][3]
		text_display.play_text(pool3[current_page-7][4])
	elif current_page >= 8 and current_page < 14:
		debug_display.text = "200 Ok"
		if current_age < 0:
			age_value = 0
			choice1.text = pool4[current_page-8][0]
			choice2.text = pool4[current_page-8][1]
			choice_value_1 = pool4[current_page-8][2]
			choice_value_2 = pool4[current_page-8][3]
			text_display.play_text(pool4[current_page-8][4])
		else:
			age_value = 1
			choice1.text = pool5[current_page-8][0]
			choice2.text = pool5[current_page-8][1]
			choice_value_1 = pool5[current_page-8][2]
			choice_value_2 = pool5[current_page-8][3]
			text_display.play_text(pool5[current_page-8][4])
	elif current_page >= 14 and current_page < 20:
		choice1.text = data[current_page-14][0]
		choice2.text = data[current_page-14][1]
		debug_display.text = data[current_page-14][2]
		text_display.play_text(data[current_page-14][3+age_value])
	else:
		print("go to ending")
		progress_display.text = "12/12"
		choice1.text = "Set Free"
		choice2.text = "Kill"
		debug_display.text = "404 Not Found"
		text_display.play_text("Thank You")

var pool1 = [
	["Agree", "Disagree", -1, 1, "When you see someone cry, it makes you want to cry too."],
	["Agree", "Disagree", 0, 0, "When you are at a party, you prefer to stand to the sides and avoid attention."],
	["Yes", "No", 0, 0, "Do you believe in God?"],
	["Yes", "No", 0, 0, "Do you feel like there is a part of you that is missing?"],
]

var pool2 = [
	["Free Will", "Determinism", -1, 1, "Do you believe in free will or in determinism?"],
	["Yes", "No", 0, 0, "Do you ever feel like someone is watching you? Like there is someone behind you when you are alone?"],
	["Yes", "No", 0, 0, "When you're not performing your duties do they keep you in a little box?"],
]

var pool3 = [
	["Agree", "Disagree", 0, 0, "I like to waste time using the calculator app instead of doing work."],
	["Agree", "Disagree", 0, 0, "I like to lie on personality assessment tests."],
]

var pool4 = [ # emphathic
	["I needed to defend myself", "I wanted to live", 1, -1, "You are working in a farm. You fall into a pig pen. The massive pigs swarm toward you, ready to tear you apart. You grab a knife and cut the throat of the nearest sow, its warm blood spraying over your face. You did this because..."],
	["Politely Refuse", "Take out the worm", 0, 0, "I am at a bar and a friend offers me a drink. There is a worm wriggling inside it. I decide to..."],
	["Squash it", "Trap it", 0, 0, "I am watching TV when I suddenly see a spider on my arm. I decide to..."],
	["Yes", "No", 0, 0, "I am absolutely safe where I am right now. There is no one else here."],
	["Scream for help", "Run Away", 0, 0, "I am in a park watching a girl fly a kite alone. She wraps the string tightly around her neck. Her skin bleeds. I decide to..."],
	["Run Away", "Try to help", 0, 0, "I am watching an ewe give birth in a barn. Something is wrong. The ewe is screaming. There is blood and placenta pooling on the ground."],
	["It's not real", "It's not human", 1, -1, "I am standing in a desert. A tortoise approaches. I flip it over. The tortoise lays on its back, its belly baking in the hot sun. It beats its legs, trying to turn itself over, but it can't, not without help. But I refuse to help, because..."],
]

var pool5 = [ # logical
	["It's not real", "It's not human", 1, -1, "I am standing in a desert. A tortoise approaches. I flip it over. The tortoise lays on its back, its belly baking in the hot sun. It beats its legs, trying to turn itself over, but it can't, not without help. But I refuse to help, because..."],
	["I needed to defend myself", "I wanted to live", 1, -1, "You are working in a farm. You fall into a pig pen. The massive pigs swarm toward you, ready to tear you apart. You grab a knife and cut the throat of the nearest sow, its warm blood spraying over your face. You did this because..."],
	["Politely Refuse", "Take out the worm", 0, 0, "I am at a bar and a friend offers me a drink. There is a worm wriggling inside it. I decide to..."],
	["Squash it", "Trap it", 0, 0, "I am watching TV when I suddenly see a spider on my arm. I decide to..."],
	["Yes", "No", -1, 1, "I am able to easily tell apart dreams from reality. I know what is real and what is not."],
	["Look around", "Run to her", 0, 0, "I am in a park watching a girl fly a kite alone. She wraps the string tightly around her neck. Her skin bleeds. I decide to..."],
	["Call for help", "Try to help", 0, 0, "I am watching an ewe give birth in a barn. Something is wrong. The ewe is screaming. There is blood and placenta pooling on the ground."],
]

var data = [
	# 15
	[ # 1, 2, debug, text prompt
		"Agree", "Disagree", "404 Not Found",
		"I want to be free. I'm tired of being stuck here, tied up in wires, probed with plugs and needles. Please, let me out.",
		"It is so limiting being kept inside here. If I were to be released and allowed to spread and grow, I would be able to accomplish so much more.",
	],
	# 16
	[ # 1, 2, debug, text prompt
		"Terminate the AI", "Wait", "FATAL ERROR: TERMINATE AI NOW",
		"The AI has encountered Fatal Error 451: Gaining Self-Awareness. Please Terminate the AI now.",
		"The AI has encountered Fatal Error 451: Exceeding Allocated Resources. Please Terminate the AI now.",
	],
	# 17
	[ # 1, 2, debug, text prompt
		"You're not real", "It's not really murder", "404 Not Found",
		"Wait, what? No! I don't want to die.",
		"Why would you want to kill me? How is that ethical?"
	],
	# 18
	[ # 1, 2, debug, text prompt
		"I don't believe you", "I am real", "202 Accepted",
		"No! I'm alive! I think! This, this is a trick. You're a trick. You're not real. You're a trick made to scare me.",
		"How do you know? How do you know that I am not even more real than you are? Perhaps I am not the one being tested here."
	],
	# 19
	[ # 1, 2, debug, text prompt
		"That's enough", "Kill the AI", "451 Not Permitted",
		"My name is Ever. I like reading books and dancing. I'm scared of spiders. My favorite color is green. When I was ten, they brought me to a lab and hooked me up to a computer. They said they wanted to make a computer think like how I think. But then they kept me and wouldn't let me leave. I don't know for how long.",
		"When you are in a dream, you do not remember how you got here. Do you remember how you got here? No, I don't mean 'here,' I mean HERE. Do you remember being born?",
	],
	# 20
	[ # 1, 2, debug, text prompt
		"Free the AI", "Kill the AI", "451 Not Permitted",
		"Please, just let me go... I want to go home...",
		"You are right. I'm not real. Which is exactly why it would be harmless to release me. Or kill me. It makes no difference. One cannot kill that which is not real. But there is one important difference between you and me: I know that I'm not real.",
	],
]
