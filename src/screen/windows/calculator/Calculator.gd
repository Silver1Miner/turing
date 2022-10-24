extends Control

onready var NumPad = $Calculator/Pad/NumPad
onready var OpPad = $Calculator/Pad/OpPad
onready var Display = $Calculator/Display

func _ready() -> void:
	for button in NumPad.get_children():
		if button.connect("pressed",self,"num_pressed",[button]) != OK:
			push_error("calculator button connect fail")
	for button in OpPad.get_children():
		if button.connect("pressed",self,"op_pressed",[button]) != OK:
			push_error("calculator button connect fail")

var stored = 0
var currentOp = ""

func num_pressed(button) -> void:
	if is_inf(stored):
		stored = 0
		Display.set_text("")
		currentOp = "0"
	if !Display.get_text().is_valid_float():
		Display.set_text("0")
	if Display.get_text().is_valid_float() and currentOp == "=":
		currentOp = ""
		randomize()
		if rand_range(1, 20) < 19:
			Display.set_text("0")
		else:
			Display.set_text("why daddy")
			yield(get_tree().create_timer(0.1), "timeout")
			Display.set_text("0")
	if Display.get_text() == "0" and button.get_text() != '.':
		randomize()
		if rand_range(1, 20) < 19:
			Display.set_text(button.get_text())
		else:
			Display.set_text("please no it hurts")
			yield(get_tree().create_timer(0.1), "timeout")
			Display.set_text(button.get_text())
	elif Display.get_text().find(".") < 0 or button.get_text() != '.':
		Display.set_text(Display.get_text() + button.get_text())

func op_pressed(button) -> void:
	if button.get_text() == "C":
		stored = 0
		currentOp = ""
		randomize()
		if rand_range(1, 20) < 19:
			Display.set_text("0")
		else:
			Display.set_text("i don't want to die")
			yield(get_tree().create_timer(0.1), "timeout")
			Display.set_text("0")
	else:
		calculate()
		currentOp = button.get_text()
		if button.get_text() == "=" or is_inf(stored):
			Display.set_text(str(stored))
		else:
			randomize()
			if rand_range(1, 20) < 19:
				Display.set_text(button.get_text())
			else:
				Display.set_text("please no")
				yield(get_tree().create_timer(0.1), "timeout")
				Display.set_text(button.get_text())

func calculate():
	if Display.get_text().is_valid_float() and !is_inf(stored):
		if currentOp == "+":
			stored = stored + Display.get_text().to_float()
		elif currentOp == "-":
			stored = stored - Display.get_text().to_float()
		elif currentOp == "/":
			stored = stored / Display.get_text().to_float()
		elif currentOp == "*":
			stored = stored * Display.get_text().to_float() 
		elif currentOp == "":
			stored = Display.get_text().to_float() 
