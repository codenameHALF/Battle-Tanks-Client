@tool
extends Button

enum skins { BLUE, GREEN, RED, YELLOW, PURPLE, BROWN, WHITE, BLACK }
var skin_refs = {}

signal select_tank(texture: CompressedTexture2D)

@onready var tank_model = $TankModel
@onready var camera = $SubViewportContainer/SubViewport/Camera3D

@export var skin: skins = skins.BLUE:
	set(value):
		skin = value
		
		if not is_node_ready():
			await ready
		
		var texture = skin_refs[skin]
		
		var material := StandardMaterial3D.new()
		material.albedo_texture = texture
		material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
		material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		tank_model.material_override = material
		tank_model.layers = 1 << (1 + skin)
		camera.cull_mask = 1 << (1 + skin)

func _enter_tree() -> void:
	skin_refs[skins.BLUE] = load("res://assets/textures/game/tanks/tank_blue.png")
	skin_refs[skins.GREEN] = load("res://assets/textures/game/tanks/tank_green.png")
	skin_refs[skins.RED] = load("res://assets/textures/game/tanks/tank_red.png")
	skin_refs[skins.YELLOW] = load("res://assets/textures/game/tanks/tank_yellow.png")
	skin_refs[skins.PURPLE] = load("res://assets/textures/game/tanks/tank_purple.png")
	skin_refs[skins.BROWN] = load("res://assets/textures/game/tanks/tank_brown.png")
	skin_refs[skins.WHITE] = load("res://assets/textures/game/tanks/tank_white.png")
	skin_refs[skins.BLACK] = load("res://assets/textures/game/tanks/tank_black.png")


func _on_pressed() -> void:
	select_tank.emit(skin_refs[skin])
