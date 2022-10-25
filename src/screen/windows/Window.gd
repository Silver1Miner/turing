extends Control

signal logout()
signal ending_reached(ending_id)

func _on_Close_pressed() -> void:
	visible = false

func _on_Settings_logout() -> void:
	visible = false
	emit_signal("logout")

func _on_Chat_ending_reached(ending_id: int):
	emit_signal("ending_reached", ending_id)
	$Chat.refresh()
	visible = false
