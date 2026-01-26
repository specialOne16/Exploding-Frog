extends Panel


func _on_play_button_pressed() -> void:
	AudioPlayer.game_started = true
	AudioPlayer.frog_jam_beginning_drums.stop()
	AudioPlayer.frog_jam_first_loop.play()
	get_tree().change_scene_to_file("res://gameplay/gameplay.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
