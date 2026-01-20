extends Control
class_name PlayerStat

@export var player: Player

@onready var progress_bar: ProgressBar = $ProgressBar

func _ready() -> void:
	progress_bar.max_value = player.max_fuel

func _process(delta: float) -> void:
	progress_bar.value = player.current_fuel
