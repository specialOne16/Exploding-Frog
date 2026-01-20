extends CharacterBody3D
class_name Player

@export var max_fuel: float = 100
@export var fuel_generation: float = 5
var current_fuel: float

func _process(delta: float) -> void:
	current_fuel += fuel_generation * delta
	
	if current_fuel > max_fuel:
		# TODO: explode
		current_fuel = max_fuel

func _physics_process(_delta: float) -> void:
	move_and_slide()
