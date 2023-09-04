extends KinematicBody2D

class_name Player

onready var stateMachine: StateMachine = get_node("StateMachine")
onready var collider: CollisionShape2D = get_node("CollisionShape2D")

const FLOOR_NORMAL := Vector2.UP

var isActive = true setget SetIsActive


func SetIsActive(value: bool) -> void:
	isActive = value
	if not collider:
		return
	collider.disabled = not value
