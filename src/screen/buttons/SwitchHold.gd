extends TextureButton

signal meter_full()
onready var progress = $TextureProgress

func _ready() -> void:
	progress.value = 0

func change_label(new_text: String) -> void:
	$Label.text = new_text

func _process(_delta: float) -> void:
	if pressed:
		if progress.value < 100:
			progress.value += 5
			if progress.value == 110:
				print("meter full")
				emit_signal("meter_full")
				pressed = false
	else:
		progress.value = 0
