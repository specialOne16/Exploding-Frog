extends PanelContainer


func _on_play_button_pressed() -> void:
	AudioPlayer.game_started = true
	get_tree().change_scene_to_file("res://gameplay/gameplay.tscn")
