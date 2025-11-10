extends Control
@onready var play_button: TextureButton = $PlayButton
@onready var quit_button: TextureButton = $QuitButton




func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://weird_banana1.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
