extends TextureRect

signal login()

func _ready() -> void:
	$NinePatchRect/LoginPage.visible = true
	$NinePatchRect/TOSPage.visible = false

func _on_Start_pressed() -> void:
	emit_signal("login")
	$NinePatchRect/LoginPage.visible = true
	$NinePatchRect/TOSPage.visible = false

func _on_Login_pressed():
	$NinePatchRect/LoginPage.visible = false
	$NinePatchRect/TOSPage.visible = true
