extends Node2D
class_name Level


@export var spawn_door: Door

@onready var doors: Node2D = $TileMapLayers/Doors
@onready var objects: Node2D = $Objects
@onready var collectables: Node2D = $Collectables
@onready var enemies: Node2D = $Enemies


func spawn_player():
	var player: Player = Game.get_player()
	
	player.state_machine.change_state("doorout")
	player.velocity = Vector2.ZERO
	player.global_position = spawn_door.global_position
	spawn_door.open_door()



func add_object(object: PhysicsObject, spawn_position: Vector2) -> void:
	if not object:
		return
	
	object.global_position = spawn_position
	objects.add_child(object)


func add_collectable(collectable: Collectable, spawn_position: Vector2) -> void:
	if not collectable:
		return
	
	collectable.global_position = spawn_position
	collectables.add_child(collectable)


func add_enemy(enemy: Enemy, spawn_position: Vector2) -> void:
	if not enemy:
		return
	
	enemy.global_position = spawn_position
	enemies.add_child(enemy)
