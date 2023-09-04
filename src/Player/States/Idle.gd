extends State

onready var movementState = get_parent()


func UnhandledInput(event: InputEvent) -> void:
	movementState.UnhandledInput(event)


func PhysicsProcess(delta: float) -> void:
	# Run if on the floor
	var isOnFloor: bool = owner.is_on_floor()
	var currentMovementDirection: Vector2 = movementState.GetMovementDirection()
	if isOnFloor && currentMovementDirection.x != 0.0:
		parentStateMachine.TransitionToNewState("Movement/Running")
	else:
		parentStateMachine.TransitionToNewState("Movement/InAir")


func EnterState(message: Dictionary = {}) -> void:
	movementState.EnterState(message)
	movementState.maxSpeed = movementState.maxSpeedDefault
	movementState.velocity = Vector2.ZERO


func ExitState() -> void:
	movementState.ExitState()
