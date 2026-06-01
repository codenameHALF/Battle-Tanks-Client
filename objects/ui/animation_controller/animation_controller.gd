extends Control

signal set_in_pos
signal set_out_pos
signal play_in_animation(reset_pos: bool)
signal play_out_animation(reset_pos: bool)
signal play_highlight_animation(target: String, reset_pos:bool)

func send_set_in_pos():
	set_in_pos.emit()

func send_set_out_pos():
	set_out_pos.emit()

func send_play_in_animation(reset_pos = true):
	play_in_animation.emit(reset_pos)

func send_play_out_animation(reset_pos = true):
	play_out_animation.emit(reset_pos)

func send_play_highlight_animation(target: String, reset_pos = true):
	play_highlight_animation.emit(target, reset_pos)
