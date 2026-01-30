extends Panel

@onready var main: Control = $Main
@onready var credits: Control = $Credits

func _ready() -> void:
	main.visible = true
	credits.visible = false

func _on_play_button_pressed() -> void:
	AudioPlayer.game_started = true
	AudioPlayer.frog_jam_beginning_drums.stop()
	AudioPlayer.frog_jam_first_loop.play()
	get_tree().change_scene_to_file("res://gameplay/gameplay.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_back_from_credit_pressed() -> void:
	main.visible = true
	credits.visible = false


func _on_credits_pressed() -> void:
	main.visible = false
	credits.visible = true
