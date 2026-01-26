extends CharacterBody3D
class_name Player

@onready var explode_vfx: GPUParticles3D = $ExplodeVFX
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

@export var max_fuel: float = 100
@export var fuel_generation: float = 15
var current_fuel: float

var _exploded = false

func _process(delta: float) -> void:
	current_fuel += fuel_generation * delta
	if current_fuel > max_fuel and not _exploded: _explode()

func _physics_process(_delta: float) -> void:
	if not _exploded: move_and_slide()

func _explode():
	_exploded = true
	explode_vfx.emitting = true
	mesh_instance_3d.visible = false
