extends CanvasLayer

func packed_scene(target: PackedScene) -> void:
	$AnimationPlayer.play('dissolve')
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(target)
	$AnimationPlayer.play_backwards('dissolve')
	print("successfully changed to %s" % target)

func change_scene(target: String, type: String = 'dissolve') -> void:
	if type == 'dissolve':
		transition_dissolve(target)

func transition_dissolve(target: String) -> void:
	$AnimationPlayer.play('dissolve')
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play_backwards('dissolve')
	get_tree().change_scene_to_file(target)
	# print("successfully changed to %s" % target)

func adding_scene(target: PackedScene) -> void:
	add_child(target.instantiate())
