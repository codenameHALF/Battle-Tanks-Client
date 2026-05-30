extends Control

@onready var title_play_button = $TitleScreen/PlayButtonContainer
@onready var title_options_button = $TitleScreen/OptionsButtonContainer
@onready var username_ok_button = $UsernameScreen/OkButtonContianer

@onready var back_button_screen = $BackButtonScreen
@onready var back_button = $BackButtonScreen/BackButtonContainer

enum screens {TITLE, USERNAME, SELECT_FULLSCREEN, LOBBIES, LOBBY, TANK_SELECT}
var screen_refs = {}
var current_screen = screens.TITLE


func _ready():
	screen_refs[screens.TITLE] = $TitleScreen
	screen_refs[screens.USERNAME] = $UsernameScreen
	screen_refs[screens.SELECT_FULLSCREEN] = $SelectFullscreenScreen
	screen_refs[screens.LOBBIES] = $LobbiesScreen
	screen_refs[screens.LOBBY] = $LobbyScreen
	screen_refs[screens.TANK_SELECT] = $TankSelectScreen
	
	for screen in screen_refs.keys():
		if screen == screens.TITLE:
			screen_refs[screen].send_set_in_pos()
		else:
			screen_refs[screen].send_set_out_pos()
		screen_refs[screen].visible = true
	
	back_button_screen.send_set_out_pos()
	back_button_screen.visible = true


'''
current_screen = screens.LOBBIES
	select_fullscreen_screen.send_play_out_animation()
	await get_tree().create_timer(.3).timeout
	lobbies_screen.send_play_in_animation()
'''

func transition_to_screen(target_screen: screens) -> void:
	screen_refs[current_screen].send_play_out_animation()
	await get_tree().create_timer(.3).timeout
	screen_refs[target_screen].send_play_in_animation()
	current_screen = target_screen


func _on_play_button_pressed() -> void:
	transition_to_screen(screens.USERNAME)
	back_button_screen.send_play_in_animation()


func _on_options_button_pressed() -> void:
	pass


func _on_ok_button_pressed() -> void:
	transition_to_screen(screens.SELECT_FULLSCREEN)


func _on_windowed_button_pressed() -> void:
	transition_to_screen(screens.LOBBIES)


func _on_fullscreen_button_pressed() -> void:
	transition_to_screen(screens.LOBBIES)


func _on_create_lobby_button_pressed() -> void:
	transition_to_screen(screens.LOBBY)


func _on_start_button_pressed() -> void:
	transition_to_screen(screens.TANK_SELECT)


func _on_back_button_pressed() -> void:
	back_button_screen.send_play_highlight_animation(back_button.name)
	await get_tree().create_timer(.15).timeout

	match current_screen:
		screens.TITLE:
			pass
		screens.USERNAME:
			back_button_screen.send_play_out_animation(false)
			transition_to_screen(screens.TITLE)
		screens.SELECT_FULLSCREEN:
			back_button_screen.send_play_in_animation(false)
			transition_to_screen(screens.USERNAME)
		screens.LOBBIES:
			back_button_screen.send_play_in_animation(false)
			transition_to_screen(screens.SELECT_FULLSCREEN)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		screens.LOBBY:
			back_button_screen.send_play_in_animation(false)
			transition_to_screen(screens.LOBBIES)
		screens.TANK_SELECT:
			back_button_screen.send_play_in_animation(false)
			transition_to_screen(screens.LOBBY)
