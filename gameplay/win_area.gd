extends Area3D
class_name WinArea

@export var gameplay: Gameplay

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		gameplay.win()
