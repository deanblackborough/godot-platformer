extends CanvasLayer

class_name TransitionManager

@onready var fade: ColorRect = ColorRect.new()

func _ready() -> void:
	fade.color = Color.BLACK
	fade.modulate.a = 0.0
	fade.set_anchors_preset(Control.PRESET_FULL_RECT)
	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(fade)
	layer = 100   # draw on top

func change_scene_with_fade(scene_path: String) -> void:
	await _fade(1.0)                         # fade out
	get_tree().change_scene_to_file(scene_path)
	await get_tree().process_frame           # wait one frame so new scene is active
	await _fade(0.0)                         # fade back in

func _fade(target_alpha: float) -> void:
	var t := create_tween()
	t.tween_property(fade, "modulate:a", target_alpha, 0.5)
	await t.finished
