@tool
extends Node2D


@export_tool_button("Create Door", "ParallaxLayer") var create_door_action = create_door


func create_door() -> void:
	var doors: Dictionary[String, Door] = {}
	var children: Array[Node] = get_children()
	for child in children:
		if child is Door:
			doors[child.name] = child
	
	var door_scene: PackedScene = preload("res://scenes/Objects/Door/door.tscn")
	var new_door: Door = door_scene.instantiate()
	
	add_child(new_door, true)
	new_door.owner = get_tree().edited_scene_root
	
	if not doors.has("SpawnDoor"):
		new_door.name = "SpawnDoor"
		move_child(new_door, 0)
		var level: Level = owner
		level.spawn_door = new_door
	else:
		new_door.name = "ExitDoor_%s" %[doors.keys().reduce(func(sum, key): return sum + 1 if "Exit" in key else 1, 0)]
