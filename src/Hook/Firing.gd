extends State


func EnterState(message: Dictionary = {}) -> void:
	owner.cooldownTimerNode.connect("timeout", self, "OnCooldownTimeout")
	owner.cooldownTimerNode.start()
	var hookTarget: HookTarget = owner.snapDetectorNode.hookTarget
	owner.arrowNode.hookPosition = hookTarget.global_position
	hookTarget.hooked_from(owner.global_position)
	owner.emit_signal("OnHookHookedOntoTarget", hookTarget.global_position)


func OnCooldownTimeout() -> void:
	parentStateMachine.TransitionToNewState("Aim")


func ExitState() -> void:
	owner.cooldownTimerNode.disconnect("timeout", self, "OnCooldownTimeout")
