extends Control

signal logout()
signal ending_reached(ending_id)

func _ready() -> void:
	if OS.has_environment("USERNAME"):
		$UserID.text = "Logged in as: " + OS.get_environment("USERNAME")
	else:
		$UserID.text = "Logged in as: Remote Connection"

func _on_ToSettings_pressed() -> void:
	for node in $Windows.get_children():
		node.visible = false
	$Windows/WindowSettings.visible = true
	roll()

func _on_ToInbox_pressed() -> void:
	for node in $Windows.get_children():
		node.visible = false
	$Windows/WindowInbox.visible = true
	roll()

func _on_ToTrainer_pressed() -> void:
	for node in $Windows.get_children():
		node.visible = false
	$Windows/WindowTrainer.visible = true
	roll()

func _on_ToCalendar_pressed() -> void:
	for node in $Windows.get_children():
		node.visible = false
	$Windows/WindowCalendar.visible = true
	$Windows/WindowCalendar/Calendar.refresh()
	roll()

func _on_ToCalculator_pressed() -> void:
	for node in $Windows.get_children():
		node.visible = false
	$Windows/WindowCalculator.visible = true
	roll()

func roll() -> void:
	randomize()
	if rand_range(0, 10) < 1:
		$Gnome.visible = true
	else:
		$Gnome.visible = false

func _on_WindowSettings_logout() -> void:
	emit_signal("logout")

func _on_ToChat_pressed() -> void:
	for node in $Windows.get_children():
		node.visible = false
	$Windows/WindowChat.visible = true
	$Windows/WindowChat/Chat.update_display()

func _on_WindowChat_ending_reached(ending_id):
	emit_signal("ending_reached", ending_id)
