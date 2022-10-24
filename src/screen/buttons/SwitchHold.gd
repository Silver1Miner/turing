extends Button

signal meter_full()
onready var progress = $TextureProgress

func _ready() -> void:
	progress.value = 0

func change_label(new_text: String) -> void:
	text = new_text

func _process(_delta: float) -> void:
	if pressed:
		if progress.value < 100:
			progress.value += 2
			if progress.value >= 100:
				print("meter full")
				emit_signal("meter_full")
				pressed = false
	else:
		progress.value = 0
