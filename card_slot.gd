extends Control
class_name CardSlot

var current_card = null
var slot_color: Color = Color(0.3, 0.3, 0.3, 0.8)

func _ready():
	custom_minimum_size = Vector2(80, 120)
	add_to_group("card_slots")
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func is_mouse_over() -> bool:
	var mouse_pos = get_global_mouse_position()
	var rect = get_global_rect()
	var result = rect.has_point(mouse_pos)
	return result

func try_place_card(card) -> bool:
	if current_card != null:
		return false  # Slot already occupied
	
	# Place card in this slot
	var parent = card.get_parent()
	parent.remove_child(card)
	add_child(card)
	card.position = Vector2.ZERO
	current_card = card
	queue_redraw()
	
	return true

func remove_card():
	if current_card:
		remove_child(current_card)
		current_card = null
		queue_redraw()

func _draw():
	# Draw slot outline
	draw_rect(Rect2(Vector2.ZERO, size), slot_color)
	draw_rect(Rect2(Vector2.ZERO, size), Color.WHITE, false, 2.0)
	
	# Draw + or slot indicator
	if current_card == null:
		var center = size / 2
		var cross_size = 20
		draw_line(center - Vector2(cross_size, 0), center + Vector2(cross_size, 0), Color.WHITE, 2.0)
		draw_line(center - Vector2(0, cross_size), center + Vector2(0, cross_size), Color.WHITE, 2.0)

