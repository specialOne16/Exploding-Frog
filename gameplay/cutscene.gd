extends Control
class_name Cutscene

@onready var label: Label = $PanelContainer/VBoxContainer/Label
@onready var timer_2: Timer = $Timer2

func _ready() -> void:
	visible = false
	timer_2.timeout.connect(stop)

func start(text: String):
	get_tree().paused = true
	label.text = text
	visible = true
	timer_2.start(3)

func stop():
	get_tree().paused = false
	visible = false
