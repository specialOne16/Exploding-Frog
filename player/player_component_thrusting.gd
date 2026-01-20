extends Node
class_name PCThrusting

@export var player: Player
@export var force = 3
@export var gravity = 10
@export var fuel_consumption = 15

func _physics_process(delta: float) -> void:
	player.velocity.y -= gravity * delta
	
	if Input.is_action_pressed("ui_accept") and player.current_fuel > 0:
		player.current_fuel -= fuel_consumption * delta
		if player.current_fuel > 0:
			player.velocity.y = force
		else:
			player.velocity.y += force * delta
	elif player.is_on_floor():
		player.velocity.y = 0 
