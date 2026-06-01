extends Control

var main_menu: Node


func _ready() -> void:
	main_menu = get_parent()


func _on_username_ok_button_pressed() -> void:
	await main_menu.play_highlight_animation(main_menu.screens.USERNAME, "UsernameOkButtonContainer")
	main_menu.transition_to_screen(main_menu.screens.FULLSCREEN)
