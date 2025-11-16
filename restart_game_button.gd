extends Button
@onready var restart_game_button: Button = $"."


func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://weird_banana1.tscn")
	
	


func _on_game_over_label_pressed() -> void:
	get_tree().quit()
