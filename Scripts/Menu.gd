extends Control

func _ready():
	pass # Replace with function body.

func _on_Button_pressed():
	get_tree().change_scene("res://Escenes/Joc.tscn")

func _on_Button2_pressed():
	get_tree().quit()
