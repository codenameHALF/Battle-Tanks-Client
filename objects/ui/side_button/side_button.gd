@tool
extends Button

@export var set_text: String = "Button":
	set(value):
		set_text = value
		update_visuals()

@export var set_icon: Texture2D:
	set(value):
		set_icon = value
		update_visuals()

@onready var button_label = $Label
@onready var button_icon = $TextureRect

func _ready():
	update_visuals()

func update_visuals():
	if not is_node_ready():
		return
	
	button_label.text = set_text
	button_icon.texture = set_icon
