extends Node

class_name StateMachine, "res://assets/icons/state_machine.svg"

"""
Generic State Machine. It creates States and delegates engine callbacks (_physics_process, _unhandled_input) to current active state
"""

export var initialState := NodePath()
onready var currentState: State = get_node(initialState) setget SetState
onready var currentStateName := currentState.name


func _init() -> void:
	add_to_group("StateMachineGroup")


func _ready() -> void:
	# wait for the owner to ready up
	yield(owner, "ready")
	currentState.EnterState()


func TransitionToNewState(targetStatePath: String, message: Dictionary = {}) -> void:
	if not has_node(targetStatePath):
		return
	var targetState := get_node(targetStatePath)
	currentState.ExitState()
	self.currentState = targetState
	currentState.EnterState(message)


func _unhandled_input(event: InputEvent) -> void:
	currentState.UnhandledInput(event)


func _physics_process(delta: float) -> void:
	currentState.PhysicsProcess(delta)


func SetState(newState: State) -> void:
	currentState = newState
	currentStateName = currentState.name
