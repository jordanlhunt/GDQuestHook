extends State

export var acclerationX: float = 5000.0


func UnhandledInput(event: InputEvent) -> void:
	var movementState = get_parent()
	movementState.UnhandledInput(event)


func PhysicsProcess(delta: float) -> void:
	var movementState = get_parent()
	# Run if on the floor
	movementState.PhysicsProcess(delta)
	var isOnFloor: bool = owner.is_on_floor()
	var targetState = ""
	if isOnFloor:
		if movementState.GetMovementDirection().x == 0.0:
			targetState = "Movement/Idle"
		else:
			targetState = "Movement/Running"
	parentStateMachine.TransitionToNewState(targetState)


func EnterState(message: Dictionary = {}) -> void:
	var movementState = get_parent()
	movementState.EnterState(message)
	movementState.currentAcceleration.x = acclerationX
	if "velocity" in message:
		movementState.velocity = message.velocity
		movementState.maxSpeed.x = max(abs(message.velocity.x), movementState.maxSpeedDefault.x)
	if "jumpImpluse" in message:
		movementState.velocity += CalculateJumpVelocity(message.jumpImpluse)


func ExitState() -> void:
	var movementState = get_parent()
	movementState.ExitState()
	movementState.currentAcceleration = movementState.accelerationDefault


func CalculateJumpVelocity(jumpImpluse = 0.0) -> Vector2:
	var movementState = get_parent()
	var retunImpluse = movementState.CalculateVelocity(
		movementState.velocity, movementState.maxSpeed, Vector2(0.0, jumpImpluse), Vector2.UP, 1.0
	)
	return retunImpluse
