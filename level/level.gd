extends StaticBody3D
class_name Level

@onready var door_explode: AnimationPlayer = $"V7_door".get_child(1)

func play_exploding_door():
	door_explode.play("Take 001")
