extends Camera3D
class_name CameraFollow

@export var following: Node3D
@export var x_tolerance: float = 3
@export var y_tolerance: float = 1

var _initial_distance: Vector3 = Vector3(0, 3, 900)

func _ready() -> void:
	_initial_distance = position - following.position

func _process(_delta: float) -> void:
	var target_position = following.position + _initial_distance
	
	if abs(position.x - target_position.x) > x_tolerance:
		position.x = target_position.x + x_tolerance * sign(position.x - target_position.x)
	
	if abs(position.y - target_position.y) > y_tolerance:
		position.y = target_position.y + y_tolerance * sign(position.y - target_position.y)
