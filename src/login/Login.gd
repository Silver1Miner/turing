extends TextureRect

signal login()

func _ready() -> void:
	pass # Replace with function body.

func _on_Start_pressed() -> void:
	emit_signal("login")
