extends Control

var main_menu: Node


func _ready() -> void:
	main_menu = get_parent()


func _on_title_play_button_pressed() -> void:
	await main_menu.play_highlight_animation(main_menu.screens.TITLE, "TitlePlayButtonContainer")
	await main_menu.transition_to_screen(main_menu.screens.USERNAME)
	main_menu.back_button_screen.send_play_in_animation()


func _on_title_options_button_pressed() -> void:
	main_menu.play_highlight_animation(main_menu.screens.TITLE, "TitleOptionsButtonContainer")
