extends Node
class_name PCThrusting

@export var player: Player
@export var force = 3
@export var gravity = 10

func _physics_process(delta: float) -> void:
	player.velocity.y -= gravity * delta
	
	if Input.is_action_pressed("ui_accept"):
		player.velocity.y = force
	elif player.is_on_floor():
		player.velocity.y = 0 
