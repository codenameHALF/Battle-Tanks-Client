extends MeshInstance3D

@export var speed: float = 1.0

func _process(delta: float) -> void:
	rotation.y += speed * delta
