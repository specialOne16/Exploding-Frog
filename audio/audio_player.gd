extends Node

@onready var frog_jam_beginning_drums: AudioStreamPlayer = $FrogJamBeginningDrums
@onready var frog_jam_extra_loops: AudioStreamPlayer = $FrogJamExtraLoops
@onready var frog_jam_first_loop: AudioStreamPlayer = $FrogJamFirstLoop

var game_started = false

func _ready() -> void:
	frog_jam_beginning_drums.play()

func _on_frog_jam_beginning_drums_finished() -> void:
	if game_started: frog_jam_first_loop.play()
	else: frog_jam_beginning_drums.play()

func _on_frog_jam_first_loop_finished() -> void:
	frog_jam_extra_loops.play()

func _on_frog_jam_extra_loops_finished() -> void:
	frog_jam_extra_loops.play()
