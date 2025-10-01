extends Control
class_name Card

@export var card_name: String = "Card"
@export var card_color: Color = Color.DODGER_BLUE

var is_dragging = false
var original_position: Vector2
var original_parent: Node
var offset: Vector2

func _ready():
	custom_minimum_size = Vector2(80, 120)
	mouse_filter = Control.MOUSE_FILTER_STOP

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			# Start dragging
			is_dragging = true
			original_position = global_position
			original_parent = get_parent()
			offset = get_global_mouse_position() - global_position
			
			# If being dragged from a slot, clear the slot
			if original_parent.has_method("remove_card"):
				original_parent.current_card = null
			
			# Move to root to draw on top
			var root = get_tree().root
			var current_global_pos = global_position
			get_parent().remove_child(self)
			root.add_child(self)
			global_position = current_global_pos

func _input(event):
	# Handle mouse release anywhere on screen
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			if is_dragging:
				is_dragging = false
				check_drop()
				get_viewport().set_input_as_handled()

func _process(_delta):
	if is_dragging:
		global_position = get_global_mouse_position() - offset

func check_drop():
	# Find card slots in the scene
	var slots = get_tree().get_nodes_in_group("card_slots")
	var dropped_on_slot = false
	var mouse_pos = get_global_mouse_position()
	
	print("Checking drop at mouse position: ", mouse_pos)
	print("Found ", slots.size(), " slots")
	
	for slot in slots:
		var slot_rect = slot.get_global_rect()
		print("Slot ", slot.name, " rect: ", slot_rect)
		
		if slot.has_method("is_mouse_over") and slot.is_mouse_over():
			print("Mouse over slot: ", slot.name)
			if slot.try_place_card(self):
				print("Card placed in slot!")
				dropped_on_slot = true
				break
	
	if not dropped_on_slot:
		print("No slot found, returning to hand")
		# Return to original position
		return_to_original()

func return_to_original():
	# Remove from root
	var root = get_parent()
	root.remove_child(self)
	
	# Add back to original parent (hand)
	original_parent.add_child(self)
	# Don't set position - let the container handle it

func _draw():
	# Draw card background
	draw_rect(Rect2(Vector2.ZERO, size), card_color)
	draw_rect(Rect2(Vector2.ZERO, size), Color.WHITE, false, 2.0)
	
	# Draw card name
	var font = ThemeDB.fallback_font
	var font_size = 14
	var text_size = font.get_string_size(card_name, HORIZONTAL_ALIGNMENT_CENTER, -1, font_size)
	var text_pos = Vector2((size.x - text_size.x) / 2, size.y - 10)
	draw_string(font, text_pos, card_name, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, Color.WHITE)

