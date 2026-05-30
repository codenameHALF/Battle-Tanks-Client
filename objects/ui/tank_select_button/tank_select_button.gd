@tool
extends Button

enum skins { BLUE, GREEN, RED, YELLOW, PURPLE, BROWN, WHITE, BLACK }

const tank_blue_texture = preload("res://assets/texture/game/tanks/tank_blue.png")
const tank_green_texture = preload("res://assets/texture/game/tanks/tank_green.png")
const tank_red_texture = preload("res://assets/texture/game/tanks/tank_red.png")
const tank_yellow_texture = preload("res://assets/texture/game/tanks/tank_yellow.png")
const tank_purple_texture = preload("res://assets/texture/game/tanks/tank_purple.png")
const tank_brown_texture = preload("res://assets/texture/game/tanks/tank_brown.png")
const tank_white_texture = preload("res://assets/texture/game/tanks/tank_white.png")
const tank_black_texture = preload("res://assets/texture/game/tanks/tank_black.png")

@onready var tank_model = $TankModel
@onready var camera = $SubViewportContainer/SubViewport/Camera3D

@export var skin: skins = skins.BLUE:
	set(value):
		skin = value
		
		if not is_node_ready():
			await ready
		
		var texture: CompressedTexture2D
		
		match skin:
			skins.BLUE:
				print("BLUE")
				texture = tank_blue_texture
			skins.GREEN:
				print("GREEN")
				texture = tank_green_texture
			skins.RED:
				print("RED")
				texture = tank_red_texture
			skins.YELLOW:
				print("YELLOW")
				texture = tank_yellow_texture
			skins.PURPLE:
				print("PURPLE")
				texture = tank_purple_texture
			skins.BROWN:
				print("BROWN")
				texture = tank_brown_texture
			skins.WHITE:
				print("WHITE")
				texture = tank_white_texture
			skins.BLACK:
				print("BLACK")
				texture = tank_black_texture
		
		var material := StandardMaterial3D.new()
		material.albedo_texture = texture
		material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
		material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		tank_model.material_override = material
		tank_model.layers = 1 << (1 + skin)
		camera.cull_mask = 1 << (1 + skin)
