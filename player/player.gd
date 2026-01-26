extends CharacterBody3D
class_name Player

@onready var explode_vfx: GPUParticles3D = $ExplodeVFX
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var walk_swim: Node3D = $"walk swim"

@export var gameplay: Gameplay
@export var max_fuel: float = 100
@export var fuel_generation: float = 15
var current_fuel: float

var _exploded = false
var win = false

func _process(delta: float) -> void:
	current_fuel += fuel_generation * delta
	if current_fuel > max_fuel and not _exploded: _explode()

func _physics_process(_delta: float) -> void:
	if not _exploded: 
		move_and_slide()
		if is_on_floor():
			var normal = get_floor_normal()
			var vec2_normal = Vector2(normal.x, normal.y)
			$"walk swim".rotation.z = vec2_normal.angle() - PI / 2
		else:
			$"walk swim".rotation.z = 0

func _explode():
	_exploded = true
	explode_vfx.emitting = true
	mesh_instance_3d.visible = false
	walk_swim.visible = false
	gameplay.exploded()


func _on_water_detector_2_area_entered(_area: Area3D) -> void:
	$FrogLandsinWater.play()
