extends Control

var main_menu: Node

@onready var tank_buttons_container = $TankButtonsContainer
@onready var tank_model = $TankSelectedTank


func _ready() -> void:
	main_menu = get_parent()
	for button in tank_buttons_container.get_children():
		button.select_tank.connect(_on_select_tank)


func _on_select_tank(texture: CompressedTexture2D):
	var material := StandardMaterial3D.new()
	material.albedo_texture = texture
	material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	material.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	tank_model.material_override = material


func _on_tank_ok_button_pressed() -> void:
	await main_menu.play_highlight_animation(main_menu.screens.TANK, "TankOkButtonContainer")
	main_menu.transition_to_screen(main_menu.screens.MAP)
