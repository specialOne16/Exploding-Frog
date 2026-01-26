extends Node
class_name PCThrusting

@onready var player: Player = $".."
@onready var thrusting_vfx: GPUParticles3D = $"../walk swim/ThrustingVFX"
@onready var water_detector: Area3D = $"../WaterDetector"
@onready var frog_deflate: AudioStreamPlayer = $"../FrogDeflate"


@export var force = 10
@export var gravity = 10
@export var fall_down_gravity = 30
@export var under_water_gravity = 4
@export var water_up_force = 2
@export var fuel_consumption = 150
@export var minimum_fuel = 30

var thrusting = false

func _physics_process(delta: float) -> void:
	if player.win: return
	
	if water_detector.get_overlapping_areas().size() > 0:
		player.velocity.y = water_up_force
	else:
		if player.velocity.y >= 0:
			player.velocity.y -= gravity * delta
		else:
			player.velocity.y -= fall_down_gravity * delta
	
	if Input.is_action_just_pressed("action"):
		if player.current_fuel > minimum_fuel: 
			thrusting = true
			thrust(delta)
	elif Input.is_action_pressed("action") and thrusting:
		if player.velocity.y > 0: thrust(delta)
	else:
		if player.is_on_floor(): player.velocity.y = 0
	
	thrusting_vfx.emitting = Input.is_action_pressed("action")
	if Input.is_action_pressed("action"):
		if not frog_deflate.playing: frog_deflate.play()
	else:
		frog_deflate.stop()

func thrust(delta: float):
	player.current_fuel -= fuel_consumption * delta
	
	if player.current_fuel <= 0:
		thrusting = false
	
	if player.velocity.y <= force:
		player.velocity.y = force
	else:
		player.velocity.y += force * delta
