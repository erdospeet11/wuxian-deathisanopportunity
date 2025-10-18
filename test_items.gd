extends Node

# Test script to verify item resources work correctly
func _ready():
	print("=== Testing Item Resources ===")
	
	# Load the test items
	var spiritual_pill = load("res://test_spiritual_essence_pill.tres") as Item
	var lightning_talisman = load("res://test_lightning_talisman.tres") as Item
	var poison_scroll = load("res://test_poison_resistance_scroll.tres") as Item
	
	# Test spiritual essence pill
	if spiritual_pill:
		print("\n--- Spiritual Essence Pill ---")
		print("Name: " + spiritual_pill.item_name)
		print("Type: " + spiritual_pill.get_type_name())
		print("Rarity: " + spiritual_pill.get_rarity_name())
		print("Realm: " + spiritual_pill.get_realm_name())
		print("Element: " + spiritual_pill.get_element_name())
		print("Spiritual Essence: " + str(spiritual_pill.spiritual_essence))
		print("Stackable: " + str(spiritual_pill.stackable))
		print("Can Use: " + str(spiritual_pill.can_use()))
		print("Detailed Description:")
		print(spiritual_pill.get_detailed_description())
	else:
		print("Failed to load Spiritual Essence Pill")
	
	# Test lightning talisman
	if lightning_talisman:
		print("\n--- Lightning Protection Talisman ---")
		print("Name: " + lightning_talisman.item_name)
		print("Type: " + lightning_talisman.get_type_name())
		print("Rarity: " + lightning_talisman.get_rarity_name())
		print("Realm: " + lightning_talisman.get_realm_name())
		print("Element: " + lightning_talisman.get_element_name())
		print("Stackable: " + str(lightning_talisman.stackable))
		print("Can Use: " + str(lightning_talisman.can_use()))
		print("Detailed Description:")
		print(lightning_talisman.get_detailed_description())
	else:
		print("Failed to load Lightning Protection Talisman")
	
	# Test poison resistance scroll
	if poison_scroll:
		print("\n--- Poison Resistance Technique Scroll ---")
		print("Name: " + poison_scroll.item_name)
		print("Type: " + poison_scroll.get_type_name())
		print("Rarity: " + poison_scroll.get_rarity_name())
		print("Realm: " + poison_scroll.get_realm_name())
		print("Element: " + poison_scroll.get_element_name())
		print("Spiritual Essence: " + str(poison_scroll.spiritual_essence))
		print("Stackable: " + str(poison_scroll.stackable))
		print("Can Use: " + str(poison_scroll.can_use()))
		print("Detailed Description:")
		print(poison_scroll.get_detailed_description())
	else:
		print("Failed to load Poison Resistance Technique Scroll")
	
	print("\n=== Item Resource Test Complete ===")


