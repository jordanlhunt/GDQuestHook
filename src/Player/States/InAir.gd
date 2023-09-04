extends State

onready var movementState = get_parent()
export var acclerationX: float = 5000.0


func UnhandledInput(event: InputEvent) -> void:
	movementState.UnhandledInput(event)


func PhysicsProcess(delta: float) -> void:
	# Run if on the floor
	var isOnFloor: bool = owner.is_on_floor()
	var currentMovementDirection: Vector2 = movementState.GetMovementDirection()
	var targetState = ""
	if isOnFloor:
		if movementState.GetMovementDirection().x == 0.0:
			targetState = "Movement/Idle"
		else:
			targetState = "Movement/Running"
		parentStateMachine.TransitionToNewState(targetState)


func EnterState(message: Dictionary = {}) -> void:
	movementState.EnterState(message)
	movementState.maxSpeed = movementState.maxSpeedDefault
	if "velocity" in message:
		movementState.velocity = message.velocity
		movementState.maxSpeed.x = max(abs(message.velocity.x), movementState.maxSpeedDefault.x)
	if "impluse" in message:
		movementState.velocity += CalculateJumpVelocity(message.jumpImpluse)


func ExitState() -> void:
	movementState.ExitState()
	movementState.currentAcceleration = movementState.accelerationDefault


func CalculateJumpVelocity(jumpImpluse = 0.0) -> Vector2:
	var retunImpluse = movementState.CalculateVelocity(
		movementState.velocity, movementState.maxSpeed, Vector2(0.0, jumpImpluse), Vector2.UP, 1.0
	)
	return retunImpluse
