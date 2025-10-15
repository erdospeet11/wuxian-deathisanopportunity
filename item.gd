extends Resource
class_name Item

@export var item_name: String = "Unknown Item"
@export var description: String = "A mysterious item with unknown properties"
@export var icon: Texture2D
@export var rarity: Rarity = Rarity.COMMON
@export var item_type: ItemType = ItemType.CONSUMABLE
@export var value: int = 1
@export var stackable: bool = true
@export var max_stack_size: int = 99

# Cultivation-specific properties
@export var spiritual_essence: int = 0  # Spiritual energy gained from item
@export var cultivation_realm: CultivationRealm = CultivationRealm.FOUNDATION
@export var elemental_affinity: ElementalAffinity = ElementalAffinity.NEUTRAL

# Usage properties
@export var use_effect: String = ""  # Description of what happens when used
@export var cooldown_time: float = 0.0  # Time before item can be used again

enum Rarity {
	COMMON,     # Gray
	UNCOMMON,   # Green  
	RARE,       # Blue
	EPIC,       # Purple
	LEGENDARY   # Gold
}

enum ItemType {
	CONSUMABLE,    # Items that are used up
	EQUIPMENT,     # Weapons, armor, accessories
	MATERIAL,      # Crafting materials
	ARTIFACT,      # Special cultivation items
	SCROLL,        # Technique scrolls
	TALISMAN       # Protective charms
}

enum CultivationRealm {
	FOUNDATION,    # Basic cultivation
	QUI_CONDENSING, # Qi gathering
	CORE_FORMATION, # Core building
	SPIRIT_REFINING, # Spirit purification
	TRANSFORMATION,  # Body transformation
	IMMORTAL       # Ascended state
}

enum ElementalAffinity {
	NEUTRAL,    # No specific element
	FIRE,       # Flame element
	WATER,      # Water element
	EARTH,      # Earth element
	WIND,       # Wind element
	LIGHTNING,  # Lightning element
	POISON,     # Toxic element
	SHADOW      # Dark element
}

func get_rarity_color() -> Color:
	match rarity:
		Rarity.COMMON:
			return Color(0.8, 0.8, 0.8, 1.0)  # Gray
		Rarity.UNCOMMON:
			return Color(0.4, 0.8, 0.4, 1.0)  # Green
		Rarity.RARE:
			return Color(0.4, 0.6, 0.9, 1.0)  # Blue
		Rarity.EPIC:
			return Color(0.7, 0.4, 0.9, 1.0)  # Purple
		Rarity.LEGENDARY:
			return Color(0.9, 0.8, 0.4, 1.0)  # Gold
		_:
			return Color.WHITE

func get_rarity_name() -> String:
	match rarity:
		Rarity.COMMON:
			return "Common"
		Rarity.UNCOMMON:
			return "Uncommon"
		Rarity.RARE:
			return "Rare"
		Rarity.EPIC:
			return "Epic"
		Rarity.LEGENDARY:
			return "Legendary"
		_:
			return "Unknown"

func get_type_name() -> String:
	match item_type:
		ItemType.CONSUMABLE:
			return "Consumable"
		ItemType.EQUIPMENT:
			return "Equipment"
		ItemType.MATERIAL:
			return "Material"
		ItemType.ARTIFACT:
			return "Artifact"
		ItemType.SCROLL:
			return "Scroll"
		ItemType.TALISMAN:
			return "Talisman"
		_:
			return "Unknown"

func get_realm_name() -> String:
	match cultivation_realm:
		CultivationRealm.FOUNDATION:
			return "Foundation"
		CultivationRealm.QUI_CONDENSING:
			return "Qi Condensing"
		CultivationRealm.CORE_FORMATION:
			return "Core Formation"
		CultivationRealm.SPIRIT_REFINING:
			return "Spirit Refining"
		CultivationRealm.TRANSFORMATION:
			return "Transformation"
		CultivationRealm.IMMORTAL:
			return "Immortal"
		_:
			return "Unknown"

func get_element_name() -> String:
	match elemental_affinity:
		ElementalAffinity.NEUTRAL:
			return "Neutral"
		ElementalAffinity.FIRE:
			return "Fire"
		ElementalAffinity.WATER:
			return "Water"
		ElementalAffinity.EARTH:
			return "Earth"
		ElementalAffinity.WIND:
			return "Wind"
		ElementalAffinity.LIGHTNING:
			return "Lightning"
		ElementalAffinity.POISON:
			return "Poison"
		ElementalAffinity.SHADOW:
			return "Shadow"
		_:
			return "Unknown"

func get_detailed_description() -> String:
	var desc = description
	if spiritual_essence > 0:
		desc += "\n\nSpiritual Essence: +" + str(spiritual_essence)
	if use_effect != "":
		desc += "\n\nEffect: " + use_effect
	return desc

func can_use() -> bool:
	# Override in subclasses for specific usage logic
	return item_type == ItemType.CONSUMABLE

func use_item() -> bool:
	# Override in subclasses for specific usage effects
	# Return true if item was successfully used
	if can_use():
		print("Used item: " + item_name)
		return true
	return false
