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

func _on_ToInbox_pressed() -> void:
	for node in $Windows.get_children():
		node.visible = false
	$Windows/WindowInbox.visible = true

func _on_ToTrainer_pressed() -> void:
	for node in $Windows.get_children():
		node.visible = false
	$Windows/WindowTrainer.visible = true

func _on_ToCalendar_pressed() -> void:
	for node in $Windows.get_children():
		node.visible = false
	$Windows/WindowCalendar.visible = true
	$Windows/WindowCalendar/Calendar.refresh()

func _on_ToCalculator_pressed() -> void:
	for node in $Windows.get_children():
		node.visible = false
	$Windows/WindowCalculator.visible = true

func _on_WindowSettings_logout() -> void:
	emit_signal("logout")

func _on_ToChat_pressed() -> void:
	for node in $Windows.get_children():
		node.visible = false
	$Windows/WindowChat.visible = true

func _on_WindowChat_ending_reached(ending_id):
	emit_signal("ending_reached", ending_id)
