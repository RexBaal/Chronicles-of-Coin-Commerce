extends "res://addons/gut/test.gd"

var inventory: Inventory


func before_each() -> void:
	inventory = Inventory.new()


func test_initial_state() -> void:
	assert_eq(inventory.player_gold, 0, "Player gold should start at 0")
	assert_eq(inventory.inventory.size(), 0, "Inventory should start empty")


func test_add_and_get_item() -> void:
	inventory.add_item("apple", 3)
	assert_true(inventory.has_item("apple", 3))
	assert_eq(inventory.get_item_quantity("apple"), 3)


func test_remove_item_success() -> void:
	inventory.add_item("wood", 5)
	var result := inventory.remove_item("wood", 2)
	assert_true(result)
	assert_eq(inventory.get_item_quantity("wood"), 3)


func test_remove_item_failure() -> void:
	inventory.add_item("stone", 1)
	var result := inventory.remove_item("stone", 2)
	assert_false(result)
	assert_eq(inventory.get_item_quantity("stone"), 1)


func test_add_and_remove_gold() -> void:
	inventory.add_gold(10)
	assert_eq(inventory.player_gold, 10)
	var result := inventory.remove_gold(5)
	assert_true(result)
	assert_eq(inventory.player_gold, 5)


func test_remove_gold_failure() -> void:
	inventory.add_gold(3)
	var result := inventory.remove_gold(5)
	assert_false(result)
	assert_eq(inventory.player_gold, 3)


func test_invalid_operations() -> void:
	inventory.add_item("iron", -1)
	assert_false(inventory.has_item("iron"))
	inventory.add_gold(-10)
	assert_eq(inventory.player_gold, 0)
	assert_false(inventory.remove_item("iron", 1))
	assert_false(inventory.remove_gold(1))
