extends Area3D

@export var text: String
@export var cutscene: Cutscene

func _on_body_entered(body: Node3D) -> void:
	if body is Player: 
		cutscene.start(text)
		queue_free.call_deferred()
