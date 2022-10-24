extends Control

func _ready() -> void:
	pass # Replace with function body.

func _on_Screen_logout() -> void:
	$Screen.visible = false
	$Login.visible = true
	$Music.play(0)

func _on_Login_login() -> void:
	$Screen.visible = true
	$Login.visible = false
	$Music.stop()
