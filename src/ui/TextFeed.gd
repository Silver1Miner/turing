extends RichTextLabel

signal text_finished()
var text_playing = true
onready var timer = $Timer

func play_text(input: String) -> void:
	set_bbcode(input)
	set_visible_characters(0)
	timer.wait_time = 0.05
	timer.autostart = true
	timer.start()

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)
	if get_visible_characters() >= get_total_character_count():
		end_text()

func end_text() -> void:
	timer.stop()
	emit_signal("text_finished")

func _on_TextureButton_pressed():
	set_visible_characters(-1)
	end_text()
