extends Node
class_name PCGroundMovement

@onready var player: Player = $".."

@export var ground_movement_speed = 5
@export var sky_movement_speed = 3
@export var water_movement_speed = 1
@onready var walk_swim: AnimationPlayer = $"../walk swim".get_child(1)
@onready var water_detector_2: Area3D = $"../WaterDetector2"
@onready var walk_swim_parent: Node3D = $"../walk swim"

@onready var frog_step_2: AudioStreamPlayer = $"../FrogStep2"
@onready var frog_swim: AudioStreamPlayer = $"../FrogSwim"

func _physics_process(_delta: float) -> void:
	if player.win: return
	var input = Input.get_axis("left", "right")
	
	if input != 0: 
		walk_swim.play("Take 001")
		walk_swim_parent.rotation.y = PI/2 if input > 0 else -PI/2
		
		if player.is_on_floor():
			if not frog_step_2.playing: frog_step_2.play()
			pass
		elif water_detector_2.get_overlapping_areas().size() > 0:
			if not frog_swim.playing: frog_swim.play()
	else:
		walk_swim.stop()
		frog_step_2.stop()
		frog_swim.stop()
	
	if player.is_on_floor():
		player.velocity.x = input * ground_movement_speed
	elif water_detector_2.get_overlapping_areas().size() > 0:
		player.velocity.x = input * water_movement_speed
	else:
		player.velocity.x = input * sky_movement_speed
