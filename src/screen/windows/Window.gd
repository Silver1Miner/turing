extends Control

signal logout()

func _on_Close_pressed() -> void:
	visible = false

func _on_Settings_logout() -> void:
	visible = false
	emit_signal("logout")
