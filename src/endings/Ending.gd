extends Control

signal ending_finished()


func play_ending(ending_id: int) -> void:
	$NinePatchRect/Title.text = "Ending: " + str(ending_id)
	visible = true

func _on_Okay_pressed():
	emit_signal("ending_finished")
