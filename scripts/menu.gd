extends VBoxContainer

@onready var start_game = $StartButton
@onready var how_to_play_button = $HowToPlayButton
@onready var howto = $"/root/Menu/UI/Rules"

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_how_to_play_button_pressed():
	howto.set_visible(true)


func _input(event):
	if event is InputEventKey:
		get_tree().change_scene_to_file("res://scenes/main.tscn")
