extends State

const SPRINT_MAX_SPEED_X = 750
const SPRINT_ACCELERATION = 200000


func UnhandledInput(event: InputEvent) -> void:
	var movementState = get_parent()
	movementState.UnhandledInput(event)


func PhysicsProcess(delta: float) -> void:
	var movementState = get_parent()
	var isOnFloor: bool = owner.is_on_floor()
	var currentMovementDirection: Vector2 = movementState.GetMovementDirection()

	# Check for Sprint
	var IsSprinting: bool = IsSprinting()
	if IsSprinting:
		movementState.maxSpeed.x =  SPRINT_MAX_SPEED_X
	else:
		movementState.maxSpeed.x = movementState.maxSpeedDefault.x

	# If on the floor and not moving go to idle else in the air
	if isOnFloor:
		if movementState.velocity.length() < 1.0:
			parentStateMachine.TransitionToNewState("Movement/Idle")
	else:
		parentStateMachine.TransitionToNewState("Movement/InAir")
	movementState.PhysicsProcess(delta)


func EnterState(message: Dictionary = {}) -> void:
	var movementState = get_parent()
	movementState.EnterState(message)


func ExitState() -> void:
	var movementState = get_parent()
	movementState.ExitState()


func IsSprinting() -> bool:
	return Input.is_action_pressed("sprint")
