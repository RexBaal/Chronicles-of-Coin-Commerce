class_name Inventory

"""
Autoload singleton for player inventory and gold management.
TODO: Add this script to Project Settings > Autoloads as "Inventory".
"""

var player_gold: int = 0
var inventory: Dictionary = {}


func add_item(item_name: String, quantity: int) -> void:
	"""Adds quantity of item_name to the inventory."""
	if quantity <= 0:
		return
	inventory[item_name] = inventory.get(item_name, 0) + quantity


func remove_item(item_name: String, quantity: int) -> bool:
	"""Removes quantity of item_name from the inventory if possible."""
	if quantity <= 0:
		return false
	if not inventory.has(item_name):
		return false
	var current: int = inventory[item_name]
	if current < quantity:
		return false
	current -= quantity
	if current <= 0:
		inventory.erase(item_name)
	else:
		inventory[item_name] = current
	return true


func has_item(item_name: String, quantity: int = 1) -> bool:
	"""Returns true if at least quantity of item_name exists."""
	return inventory.get(item_name, 0) >= quantity


func get_item_quantity(item_name: String) -> int:
	"""Returns current quantity for item_name or 0."""
	return inventory.get(item_name, 0)


func add_gold(amount: int) -> void:
	"""Adds amount of gold to player_gold."""
	if amount <= 0:
		return
	player_gold += amount


func remove_gold(amount: int) -> bool:
	"""Attempts to remove gold and returns true if successful."""
	if amount <= 0:
		return false
	if player_gold < amount:
		return false
	player_gold -= amount
	return true
