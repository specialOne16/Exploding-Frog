extends Node
class_name PCGroundMovement

@export var player: Player
@export var ground_movement_speed = 5
@export var sky_movement_speed = 3

func _physics_process(delta: float) -> void:
	var input = Input.get_axis("ui_left", "ui_right")
	
	if player.is_on_floor():
		player.velocity.x = input * ground_movement_speed
	else:
		var sky_acceleration = 1 if sign(player.velocity.x) == sign(input) else 3
		player.velocity.x = move_toward(player.velocity.x, input * sky_movement_speed, delta * sky_acceleration)
