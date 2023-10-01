extends Area2D

onready var hookHintNode: Position2D = get_node("HookHint")
onready var rayCastNode: RayCast2D = get_node("RayCast2D")
var hookTarget: HookTarget setget SetTarget


func _ready() -> void:
	rayCastNode.set_as_toplevel(true)


func _physics_process(delta: float) -> void:
	self.hookTarget = FindBestTarget()


func FindBestTarget() -> HookTarget:
	var closestTarget: HookTarget = null
	var targetsList := get_overlapping_areas()
	for target in targetsList:
		if not target.is_active:
			continue
		rayCastNode.global_position = self.global_position
		rayCastNode.cast_to = target.global_position - rayCastNode.global_position
		# Hit obstacle
		if rayCastNode.is_colliding():
			continue
		closestTarget = target
		break
	return closestTarget


func HasTarget() -> bool:
	var hasTarget: bool = false
	if hookTarget:
		hasTarget = true
	return hasTarget


func SetTarget(value: HookTarget) -> void:
	hookTarget = value
	hookHintNode.visible = HasTarget()
	if hookTarget:
		hookHintNode.global_position = hookTarget.global_position
