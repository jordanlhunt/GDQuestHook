extends State

"""
Parent State that abstracts and handles movement
Movement-related child states can delegate movement to it, or use its utility functions
"""

export var maxSpeedDefault = Vector2(500.0, 1500.0)
export var accelerationDefault = Vector2(100000, 3000.0)
export var jumpImpluse: float = 900.0

var currentAcceleration: Vector2 = accelerationDefault
var maxSpeed: Vector2 = maxSpeedDefault
var velocity: Vector2 = Vector2.ZERO


func UnhandledInput(event: InputEvent) -> void:
	if owner.is_on_floor() and event.is_action_pressed("jump"):
		parentStateMachine.TransitionToNewState("Movement/InAir", {impluse = jumpImpluse})


func PhysicsProcess(delta: float) -> void:
	velocity = CalculateVelocity(
		velocity, maxSpeed, accelerationDefault, GetMovementDirection(), delta
	)
	velocity = owner.move_and_slide(velocity, owner.FLOOR_NORMAL)
	Events.emit_signal("player_moved", owner)


static func CalculateVelocity(
	currentVelocity: Vector2,
	maxSpeedClamp: Vector2,
	accleration: Vector2,
	movementDirection: Vector2,
	deltaTime: float
) -> Vector2:
	var newVelocity = currentVelocity
	newVelocity += movementDirection * accleration * deltaTime
	# Clamp doesn't work on vectors, only floating point values. Clamp X and Y individually
	newVelocity.x = clamp(newVelocity.x, -maxSpeedClamp.x, maxSpeedClamp.x)
	newVelocity.y = clamp(newVelocity.y, -maxSpeedClamp.y, maxSpeedClamp.y)
	return newVelocity


static func GetMovementDirection() -> Vector2:
	var movementDirection = Vector2(
		Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft"), 1.0
	)

	return movementDirection
