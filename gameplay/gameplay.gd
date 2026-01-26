extends Node3D
class_name Gameplay

@onready var player_stat: PlayerStat = $CanvasLayer/PlayerStat
@onready var end_game: Control = $CanvasLayer/EndGame
@onready var died: Control = $CanvasLayer/Died
@onready var level: Level = $Level
@onready var camera_follow: CameraFollow = $CameraFollow
@onready var timer: Timer = $Timer
@onready var player: Player = $Player
@onready var frog_death: AudioStreamPlayer = $FrogDeath

func _ready() -> void:
	player_stat.visible = true
	end_game.visible = false
	died.visible = false

func _process(_delta: float) -> void:
	if OS.is_debug_build(): cheat()

func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func exploded():
	frog_death.play()
	await get_tree().create_timer(1).timeout
	get_tree().paused = true
	player_stat.visible = false
	died.visible = true

func win():
	player.fuel_generation = 0
	player.win = true
	player.velocity = Vector3.ZERO
	timer.timeout.connect(launch_player)
	level.door_explode.animation_finished.connect(explode_finished)
	camera_follow.following = null
	timer.start(5)
	level.play_exploding_door()

func cheat():
	if Input.is_action_just_pressed("ui_cancel"):
		$Player.position = $"Cheat Point".position

func explode_finished(_animation_name):
	get_tree().paused = true
	player_stat.visible = false
	end_game.visible = true

func launch_player():
	$Player.velocity = Vector3.UP * 120
	$FrogHouseExplodes.play()
