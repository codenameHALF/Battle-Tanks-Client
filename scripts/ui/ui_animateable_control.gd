@tool
extends Control

@export var parent_path: NodePath

@export var duration: float = 0.3
@export var easing: Tween.EaseType = Tween.EASE_OUT

@export var in_pos: Vector2
@export_tool_button("Copy To In")
var copy_to_in_action = _on_copy_to_in
@export_tool_button("Move To In")
var move_to_in_action = _on_set_in_pos

@export var out_pos: Vector2
@export_tool_button("Copy To Out")
var copy_to_out_action = _on_copy_to_out
@export_tool_button("Move To Out")
var move_to_out_action = _on_set_out_pos

@export var highlight_pos: Vector2
@export_tool_button("Copy To Highlight")
var copy_to_highlight_action = _on_copy_to_highlight
@export_tool_button("Move To Highlight")
var move_to_highlight_action = _on_set_highlight_pos

func _ready():
	var parent = get_node(parent_path)
	parent.set_in_pos.connect(_on_set_in_pos)
	parent.set_out_pos.connect(_on_set_out_pos)
	parent.play_in_animation.connect(_on_play_in_animation)
	parent.play_out_animation.connect(_on_play_out_animation)
	parent.play_highlight_animation.connect(_on_play_highlight_animation)
	

func _on_copy_to_in():
	in_pos = self.global_position

func _on_copy_to_out():
	out_pos = self.global_position

func _on_copy_to_highlight():
	highlight_pos = self.global_position

func _on_set_in_pos():
	self.global_position = in_pos

func _on_set_out_pos():
	self.global_position = out_pos

func _on_set_highlight_pos():
	self.global_position = highlight_pos

func _on_play_in_animation(reset_pos):
	if reset_pos:
		self.global_position = out_pos
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(easing)
	tween.tween_property(self, "global_position", in_pos, duration)

func _on_play_out_animation(reset_pos):
	if reset_pos:
		self.global_position = in_pos
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(easing)
	tween.tween_property(self, "global_position", out_pos, duration)

func _on_play_highlight_animation(target: String, reset_pos) -> void:
	if target == self.name:
		if reset_pos:
			self.global_position = in_pos
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(easing)
		tween.tween_property(self, "global_position", highlight_pos, .15)
