extends TextureButton

export var identity = "MAIL"
export var icon_texture = preload("res://assets/button/buttonLong_blue.png")
signal icon_pressed()

func _ready() -> void:
	texture_disabled = icon_texture
	texture_focused = icon_texture
	texture_hover = icon_texture
	texture_normal = icon_texture
	texture_pressed = icon_texture
	#$Label.text = identity
	if connect("pressed", self, "_on_pressed") != OK:
		push_error("fail to connect icon press signal")

func _on_pressed() -> void:
	emit_signal("icon_pressed")
	texture_disabled = icon_texture
	texture_focused = icon_texture
	texture_hover = icon_texture
	texture_normal = icon_texture
	texture_pressed = icon_texture
