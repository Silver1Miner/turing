extends Control

signal logout()
var start = false

func _ready() -> void:
	$VolumeControls/SoundVolume.set_value(PlayerData.sound_db)
	start = true

func _on_SoundVolume_value_changed(value: float) -> void:
	PlayerData.sound_db = value
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Sound"), linear2db(value)
	)
	if start:
		$AudioStreamPlayer.play()

func _on_SwitchHold_meter_full() -> void:
	emit_signal("logout")
