extends State

var hookMaxSpeed: float = 1500.0
var inAirPush: float = 500.0

var targetGlobalPosition: Vector2 = Vector2(INF, INF)
var velocity: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	var newVelocity := Steering.arrive_to(
		self.velocity, owner.global_position, self.targetGlobalPosition, hookMaxSpeed
	)
	# Clamp newVelocity value
	if newVelocity.length() > inAirPush:
		newVelocity = newVelocity
	else:
		newVelocity.normalized() * inAirPush
	newVelocity = owner.move_and_slide(newVelocity, owner.FLOOR_NORMAL)
	Events.emit_signal("player_moved", owner)
	var toTarget: Vector2 = targetGlobalPosition - owner.global_position
	var distanceToTarget := toTarget.length()
	if distanceToTarget < velocity.length() * delta:
		newVelocity = newVelocity.normalized() * inAirPush
		parentStateMachine.TransitionToNewState("Movement/InAir", {velocity = newVelocity})



func EnterState(message: Dictionary = {}) -> void:
	match message:
		{"hookTargetGlobalPosition": var hookTargetGlobalPosition, "velocity": var hookVelocity}:
			self.targetGlobalPosition = hookTargetGlobalPosition
			self.velocity = hookVelocity
		_:
			return


func ExitState() -> void:
	self.targetGlobalPosition = Vector2(INF, INF)
	self.velocity = Vector2.ZERO
