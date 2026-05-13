extends CanvasLayer
# Modified by rake


func packed_scene(target: PackedScene) -> void:
	transition_dissolve()
	get_tree().change_scene_to_packed(target)
	print("successfully changed to %s" % target)

func change_scene(target: String) -> void:
	transition_dissolve()
	get_tree().change_scene_to_file(target)
	print("successfully changed to %s" % target)

func transition_dissolve(value = ["all", "in", "out"]) -> void:
	match value:
		"all":
			$AnimationPlayer.play('dissolve')
			await $AnimationPlayer.animation_finished
			$AnimationPlayer.play_backwards('dissolve')
		"in":
			$AnimationPlayer.play('dissolve')
			await $AnimationPlayer.animation_finished
		"out":
			$AnimationPlayer.play_backwards('dissolve')
	# print("successfully changed to %s" % target)

