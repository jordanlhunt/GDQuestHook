extends State

"""
Parent State that abstracts and handles movement
Movement-related child states can delegate movement to it, or use its utility functions
"""

export var accelerationDefault: Vector2 = Vector2(100000, 3000.0)
export var decelerationDefault: Vector2 = Vector2(5000, 3000.0)
export var jumpImpluse: float = 900.0
export var maxSpeedDefault = Vector2(500.0, 1500.0)
var currentAcceleration: Vector2 = accelerationDefault
var currentDeceleration: Vector2 = decelerationDefault
var maxSpeed: Vector2 = maxSpeedDefault
var velocity: Vector2 = Vector2.ZERO

var isDoubleJumpAvailable: bool = true


func UnhandledInput(event: InputEvent) -> void:
	if owner.is_on_floor() and event.is_action_pressed("jump"):
		parentStateMachine.TransitionToNewState("Movement/InAir", {jumpImpluse = jumpImpluse})
	if !(owner.is_on_floor()) && event.is_action_pressed("jump"):
		if isDoubleJumpAvailable:
			isDoubleJumpAvailable = false
			parentStateMachine.TransitionToNewState("Movement/InAir", {jumpImpluse = jumpImpluse})
	else:
		isDoubleJumpAvailable = true


func PhysicsProcess(delta: float) -> void:
	velocity = CalculateVelocity(
		velocity, maxSpeed, currentAcceleration, currentDeceleration, GetMovementDirection(), delta
	)
	velocity = owner.move_and_slide(velocity, owner.FLOOR_NORMAL)
	Events.emit_signal("player_moved", owner)


# TODO: Tighten up deceleration ratye
static func CalculateVelocity(
	currentVelocity: Vector2,
	maxSpeedClamp: Vector2,
	accleration: Vector2,
	deceleration: Vector2,
	movementDirection: Vector2,
	deltaTime: float
) -> Vector2:
	var newVelocity = currentVelocity
	newVelocity.y += movementDirection.y * accleration.y * deltaTime
	if movementDirection.x:
		newVelocity.x += movementDirection.x * accleration.x * deltaTime
	# Not moving but still has some speed
	elif abs(newVelocity.x) > 0.1:
		newVelocity.x -= deceleration.x * deltaTime * sign(newVelocity.x)
		if sign(newVelocity.x) == sign(currentVelocity.x):
			newVelocity.x = newVelocity.x
		else:
			newVelocity.x = 0

	# Clamp doesn't work on vectors, only floating point values. Clamp X and Y individually
	newVelocity.x = clamp(newVelocity.x, -maxSpeedClamp.x, maxSpeedClamp.x)
	newVelocity.y = clamp(newVelocity.y, -maxSpeedClamp.y, maxSpeedClamp.y)
	return newVelocity


static func GetMovementDirection() -> Vector2:
	var movementDirection = Vector2(
		Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft"), 1.0
	)

	return movementDirection
