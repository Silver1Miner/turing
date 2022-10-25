extends Control

func _ready() -> void:
	pass # Replace with function body.

func _on_Screen_logout() -> void:
	$Screen.visible = false
	$Login.visible = true
	$Ending.visible = false
	$Music.play(0)

func _on_Login_login() -> void:
	$Screen.visible = true
	$Login.visible = false
	$Ending.visible = false
	$Music.stop()

func _on_Screen_ending_reached(ending_id):
	$Screen.visible = false
	$Login.visible = false
	$Ending.play_ending(ending_id)

func _on_Ending_ending_finished():
	_on_Screen_logout()
