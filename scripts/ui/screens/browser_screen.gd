extends Control

var main_menu: Node


func _ready() -> void:
	main_menu = get_parent()


func _on_browser_create_lobby_button_pressed() -> void:
	main_menu.transition_to_screen(main_menu.screens.LOBBY)
