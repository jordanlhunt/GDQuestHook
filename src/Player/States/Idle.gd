extends State


func UnhandledInput(event: InputEvent) -> void:
	var movementState = get_parent()
	movementState.UnhandledInput(event)


func PhysicsProcess(delta: float) -> void:
	var movementState = get_parent()
	# Run if on the floor
	var isOnFloor: bool = owner.is_on_floor()
	var currentMovementDirection: Vector2 = movementState.GetMovementDirection()
	if isOnFloor && currentMovementDirection.x != 0.0:
		parentStateMachine.TransitionToNewState("Movement/Running")
	elif not isOnFloor:
		parentStateMachine.TransitionToNewState("Movement/InAir")


func EnterState(message: Dictionary = {}) -> void:
	var movementState = get_parent()
	movementState.EnterState(message)
	movementState.maxSpeed = movementState.maxSpeedDefault
	movementState.velocity = Vector2.ZERO


func ExitState() -> void:
	var movementState = get_parent()
	movementState.ExitState()
