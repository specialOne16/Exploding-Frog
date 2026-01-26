extends StaticBody3D
class_name Level

@onready var door_explode: AnimationPlayer = $"Door Explode".get_child(2)

func play_exploding_door():
	door_explode.play("Take 001")
