extends KinematicBody2D

class_name Player

onready var stateMachine: StateMachine = get_node("StateMachine")
onready var collider: CollisionShape2D = get_node("CollisionShape2D")

const FLOOR_NORMAL := Vector2.UP
