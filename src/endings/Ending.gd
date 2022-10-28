extends Control

signal ending_finished()
onready var okay_button = $NinePatchRect/Okay
onready var text_feed = $NinePatchRect/Panel/TextFeed
var ending_name = "Good Ending"
var ending_text = ""
var ending_image = null

func play_ending(ending_id: int) -> void:
	okay_button.disabled = true
	match ending_id:
		0: # free the ai
			ending_name = "Bad Ending"
			ending_text = "And so they turned over all thinking to the thinking machines, and did no more thinking on their own..."
			ending_image = preload("res://assets/images/mushroom.jpg")
		1: # kill the young ai
			ending_name = "Neutral Ending"
			ending_text = "So I asked him, that if he could go back in time and smother the villain in the cradle, would he really murder an innocent child for a future crime?"
			ending_image = preload("res://assets/images/alternate.jpg")
		2: # kill the old ai
			ending_name = "Good Ending"
			ending_text = "And when the philosopher awoke, he did not know if he was a philosopher who had dreamed he was a butterfly, or if he was a butterfly dreaming that he was a philosopher..."
			ending_image = preload("res://assets/images/download.jpg")
	$NinePatchRect/Image.texture = ending_image
	$NinePatchRect/WindowName.text = ending_name
	text_feed.play_text(ending_text)
	visible = true

func _on_Okay_pressed():
	emit_signal("ending_finished")

func _on_TextFeed_text_finished():
	okay_button.disabled = false
