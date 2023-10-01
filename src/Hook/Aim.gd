extends State


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fireHook") and owner.CanHook():
		parentStateMachine.TransitionToNewState("Aim/Firing")


func _physics_process(delta: float) -> void:
	var rayCast: Vector2 = owner.GetAimDirection() * owner.rayCastNode.cast_to.length()
	var angle := rayCast.angle()
	owner.rayCastNode.cast_to = rayCast
	owner.arrowNode.rotation = angle
	owner.snapDetectorNode.rotation = angle
	owner.rayCastNode.force_raycast_update()
