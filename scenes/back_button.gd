extends Button


var back_button_container: TextureRect
var normal_texture = preload("res://assets/textures/ui/back_button_screen/back_button.png")
var highlight_texture = preload("res://assets/textures/ui/back_button_screen/back_button_highligh.png")

func _ready():
	back_button_container = get_parent()

func _on_mouse_entered() -> void:
	back_button_container.texture = highlight_texture


func _on_mouse_exited() -> void:
	back_button_container.texture = normal_texture


func _on_pressed() -> void:
	back_button_container.texture = normal_texture
