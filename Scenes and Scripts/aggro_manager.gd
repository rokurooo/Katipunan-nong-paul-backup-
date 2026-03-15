extends Node
class_name AggroManager

var aggroed_enemies: Dictionary = {}  # {enemy_instance: target_instance}

# MAIN: Try to assign enemy to a target (returns true if successful)
func register_aggro(enemy: Node2D, preferred_target: Node2D) -> bool:
	# Count current aggro on preferred_target
	var target_count = 0
	for e in aggroed_enemies:
		if aggroed_enemies[e] == preferred_target:
			target_count += 1
	
	if target_count >= 3:  # MAX 3 REACHED
		return false  # Reject! (overflow to other targets)
	
	# SUCCESS: Assign
	aggroed_enemies[enemy] = preferred_target
	print("✅ ", preferred_target.name, " aggroed ", enemy.name, " (", target_count + 1, "/3)")
	return true

# Remove when enemy dies/leaves range
func unregister_aggro(enemy: Node2D):
	aggroed_enemies.erase(enemy)
	print("❌ ", enemy.name, " de-aggroed")

# Query: What target is this enemy assigned to?
func get_target_for_enemy(enemy: Node2D) -> Node2D:
	return aggroed_enemies.get(enemy)
