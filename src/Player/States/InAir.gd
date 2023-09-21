extends State

export var acclerationX: float = 5000.0
export var jumpImpluse: float = 900.0
var isDoubleJumpAvailable: bool = true
var jumpCount = 0


func UnhandledInput(event: InputEvent) -> void:
	var movementState = get_parent()
	if event.is_action_pressed("jump") and jumpCount < 2:
		Jump()
		jumpCount += 1
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
		# Maintain max speed in the air
		movementState.maxSpeed.x = max(abs(message.velocity.x), movementState.maxSpeedDefault.x)
	if "jumpImpluse" in message:
		Jump()


func ExitState() -> void:
	var movementState := get_parent()
	movementState.ExitState()
	jumpCount = 0
	movementState.currentAcceleration = movementState.accelerationDefault


func CalculateJumpVelocity(jumpImpluse: float = 0.0) -> Vector2:
	var movementState = get_parent()
	var retunImpluse = movementState.CalculateVelocity(
		movementState.velocity,
		movementState.maxSpeed,
		Vector2(0.0, jumpImpluse),
		Vector2.ZERO,
		Vector2.UP,
		1.0
	)
	return retunImpluse


func Jump() -> void:
	var movementState := get_parent()
	movementState.velocity += CalculateJumpVelocity(jumpImpluse)
