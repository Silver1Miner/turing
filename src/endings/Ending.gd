extends Control

signal ending_finished()
var ending_name = "Good Ending"

func play_ending(ending_id: int) -> void:
	match ending_id:
		0: # free the ai
			ending_name = "Bad Ending"
		1: # kill the young ai
			ending_name = "Neutral Ending"
		2: # kill the old ai
			ending_name = "Good Ending"
	$NinePatchRect/WindowName.text = ending_name
	visible = true

func _on_Okay_pressed():
	emit_signal("ending_finished")
