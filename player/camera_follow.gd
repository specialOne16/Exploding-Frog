extends Camera3D
class_name CameraFollow

@export var following: Node3D
@export var x_tolerance: float = 4
@export var y_tolerance: float = 4

var _initial_distance: Vector3

func _ready() -> void:
	_initial_distance = position - following.position

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	var target_position = following.position + _initial_distance
	
	#if abs(position.x - target_position.x) > x_tolerance:
		#var distance = abs(target_position.x - position.x)
		#position.x = move_toward(position.x, target_position.x, delta * distance)
	#
	#if abs(position.y - target_position.y) > x_tolerance:
		#var distance = abs(target_position.y - position.y)
		#position.y = move_toward(position.y, target_position.y, delta * distance)
	
	position = target_position
