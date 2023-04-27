extends Node

signal grant_experience(exp_amount: int)
signal levelled_up(new_level: int)
signal heal_player(amount: int)
signal drop_loot(item: Item, global_position: Vector2)
signal item_picked_up(item: Item)
signal inventory_full
signal coin_picked_up(coin_value: int)
signal update_coins_ui(current_coins: int)
signal switch_scene(path: String)
signal player_entered_town_portal
