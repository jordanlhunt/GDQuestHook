extends Node

class_name StateMachine, "res://assets/icons/state_machine.svg"

"""
Generic State Machine. It creates States and delegates engine callbacks (_physics_process, _unhandled_input) to current active state
"""
