extends Node2D
class_name UIHeart


@onready var idle_animation: Sprite2D = $IdleAnimation
@onready var hit_animation: AnimatedSprite2D = $HitAnimation


func add():
	idle_animation.visible = true
	hit_animation.visible = false


func remove():
	if idle_animation.visible:
		idle_animation.visible = false
		hit_animation.visible = true
		hit_animation.play("hit")


func _on_hit_animation_animation_finished() -> void:
	hit_animation.visible = false
