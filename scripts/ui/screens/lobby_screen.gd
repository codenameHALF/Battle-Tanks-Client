extends Control

var main_menu: Node


func _ready() -> void:
	main_menu = get_parent()


func _on_lobby_start_button_pressed() -> void:
	await main_menu.play_highlight_animation(main_menu.screens.LOBBY, "LobbyStartButtonContainer")
	main_menu.transition_to_screen(main_menu.screens.TANK)
