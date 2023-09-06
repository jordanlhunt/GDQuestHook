extends Node
class_name State, "res://assets/icons/state.svg"
"""
An interface to use in the Hierarchical State Machine
The lowest leaf tries to handle callbacks. If it cannot it delegates the work to its parent.
Use State as a child of a StateMachine node.
"""

# Reference to the StateMachine it belongs to
onready var parentStateMachine := GetStateMachine(self)


# A recursive call to get the StateMachine node a state belongs to
func GetStateMachine(node: Node) -> Node:
	if node != null and not node.is_in_group("StateMachineGroup"):
		return GetStateMachine(node.get_parent())
	return node


func UnhandledInput(event: InputEvent) -> void:
	pass


func PhysicsProcess(delta: float) -> void:
	pass


func EnterState(message: Dictionary = {}) -> void:
	pass


func ExitState() -> void:
	pass
