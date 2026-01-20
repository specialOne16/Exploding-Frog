extends Node
class_name PCThrusting

@onready var player: Player = $".."
@onready var thrusting_vfx: GPUParticles3D = $"../ThrustingVFX"

@export var force = 3
@export var gravity = 10
@export var fuel_consumption = 15

func _physics_process(delta: float) -> void:
	player.velocity.y -= gravity * delta
	
	if Input.is_action_pressed("ui_accept") and player.current_fuel > 0:
		player.current_fuel -= fuel_consumption * delta
		if player.current_fuel > 0:
			player.velocity.y = force
			thrusting_vfx.emitting = true
		else:
			player.velocity.y += force * delta
			thrusting_vfx.emitting = false
		
	else:
		if player.is_on_floor(): player.velocity.y = 0
		thrusting_vfx.emitting = false
