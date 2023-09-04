extends State

onready var movementState = get_parent()


func UnhandledInput(event: InputEvent) -> void:
	movementState.UnhandledInput(event)


func PhysicsProcess(delta: float) -> void:
	var isOnFloor: bool = owner.is_on_floor()
	var currentMovementDirection: Vector2 = movementState.GetMovementDirection()
	# If on the floor and not moving go to idle
	if isOnFloor:
		if currentMovementDirection.x == 0.0:
			parentStateMachine.TransitionToNewState("Movement/Idle")
	else:
		parentStateMachine.TransitionToNewState("Movement/Air")
	movementState.PhysicsProcess(delta)


func EnterState(message: Dictionary = {}) -> void:
	movementState.EnterState(message)


func ExitState() -> void:
	movementState.ExitState()
