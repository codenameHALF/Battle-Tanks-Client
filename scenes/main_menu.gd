extends Control

@onready var back_button_screen = $BackButtonScreen
@onready var back_button = $BackButtonScreen/BackButtonContainer

enum screens {TITLE, USERNAME, FULLSCREEN, BROWSER, LOBBY, TANK, MAP}
var screen_refs = {}
var current_screen = screens.TITLE


func _ready():
	# Screens setup
	screen_refs[screens.TITLE] = $TitleScreen
	screen_refs[screens.USERNAME] = $UsernameScreen
	screen_refs[screens.FULLSCREEN] = $FullscreenScreen
	screen_refs[screens.BROWSER] = $BrowserScreen
	screen_refs[screens.LOBBY] = $LobbyScreen
	screen_refs[screens.TANK] = $TankScreen
	screen_refs[screens.MAP] = $MapScreen
	
	for screen in screen_refs.keys():
		if screen == screens.TITLE:
			screen_refs[screen].get_node("AnimationController").send_set_in_pos()
		else:
			screen_refs[screen].get_node("AnimationController").send_set_out_pos()
		screen_refs[screen].visible = true
	
	back_button_screen.send_set_out_pos()
	back_button_screen.visible = true


func play_highlight_animation(target_screen: screens, name: String) -> void:
	screen_refs[target_screen].get_node("AnimationController").send_play_highlight_animation(name)
	await get_tree().create_timer(.15).timeout
	screen_refs[target_screen].get_node("AnimationController").send_play_in_animation(false)
	await get_tree().create_timer(.15).timeout


func transition_to_screen(target_screen: screens) -> void:
	screen_refs[current_screen].get_node("AnimationController").send_play_out_animation()
	await get_tree().create_timer(.3).timeout
	screen_refs[target_screen].get_node("AnimationController").send_play_in_animation()
	current_screen = target_screen


func _on_back_button_pressed() -> void:
	back_button_screen.send_play_highlight_animation(back_button.name)
	await get_tree().create_timer(.15).timeout

	match current_screen:
		screens.TITLE:
			pass
		screens.USERNAME:
			back_button_screen.send_play_out_animation(false)
			transition_to_screen(screens.TITLE)
		screens.FULLSCREEN:
			back_button_screen.send_play_in_animation(false)
			transition_to_screen(screens.USERNAME)
		screens.BROWSER:
			back_button_screen.send_play_in_animation(false)
			transition_to_screen(screens.FULLSCREEN)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		screens.LOBBY:
			back_button_screen.send_play_in_animation(false)
			transition_to_screen(screens.BROWSER)
		screens.TANK:
			back_button_screen.send_play_in_animation(false)
			transition_to_screen(screens.LOBBY)
		screens.MAP:
			back_button_screen.send_play_in_animation(false)
			transition_to_screen(screens.TANK)
