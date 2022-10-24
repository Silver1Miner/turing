extends Control

func _ready() -> void:
	pass # Replace with function body.

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

func _on_ToCalculator_pressed() -> void:
	for node in $Windows.get_children():
		node.visible = false
	$Windows/WindowCalculator.visible = true
