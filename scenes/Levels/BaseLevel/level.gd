extends Node2D
class_name Level


@export var spawn_door: Door = null

@onready var terrain_layer: TileMapLayer = $TileMapLayers/TerrainLayer
@onready var doors_layer: Node2D = $TileMapLayers/DoorsLayer
@onready var decorations_layer: TileMapLayer = $TileMapLayers/DecorationsLayer
@onready var objects_layer: TileMapLayer = $TileMapLayers/ObjectsLayer
@onready var collectables_layer: TileMapLayer = $TileMapLayers/CollectablesLayer
@onready var enemies_layer: TileMapLayer = $TileMapLayers/EnemiesLayer


func spawn_player():
	if not Game.player:
		Game.load_player()
	
	var player: Player = Game.get_player()
	
	player.state_machine.change_to_state("doorout")
	player.velocity = Vector2.ZERO
	player.global_position = spawn_door.global_position
	player.player_camera.reset_smoothing()
	spawn_door.open_door()


func add_object(object: PhysicsObject, spawn_position: Vector2) -> void:
	if not object:
		return
	
	object.global_position = spawn_position
	objects_layer.add_child.call_deferred(object, true)


func add_collectable(collectable: Collectable, spawn_position: Vector2) -> void:
	if not collectable:
		return
	
	collectable.global_position = spawn_position
	collectables_layer.add_child.call_deferred(collectable, true)


func add_enemy(enemy: Enemy, spawn_position: Vector2) -> void:
	if not enemy:
		return
	
	enemy.global_position = spawn_position
	enemies_layer.add_child.call_deferred(enemy, true)
