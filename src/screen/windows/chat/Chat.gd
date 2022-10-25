extends Control

func _ready() -> void:
	$CameraView.visible = false


func _on_Button1_pressed() -> void:
	pass # Replace with function body.

func _on_Button2_pressed() -> void:
	pass # Replace with function body.

func _on_Button3_pressed() -> void:
	pass # Replace with function body.

func _on_Button4_pressed() -> void:
	pass # Replace with function body.


func _on_SwitchHold_meter_full() -> void:
	$CameraView.visible = !$CameraView.visible
