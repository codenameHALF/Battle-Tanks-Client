extends Control

var main_menu: Node


func _ready() -> void:
	main_menu = get_parent()


func _on_fullscreen_windowed_button_pressed() -> void:
	await main_menu.play_highlight_animation(main_menu.screens.FULLSCREEN, "FullscreenWindowedButton")
	main_menu.transition_to_screen(main_menu.screens.BROWSER)


func _on_fullscreen_fullscreen_button_pressed() -> void:
	await main_menu.play_highlight_animation(main_menu.screens.FULLSCREEN, "FullscreenFullScreenButton")
	main_menu.transition_to_screen(main_menu.screens.BROWSER)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
