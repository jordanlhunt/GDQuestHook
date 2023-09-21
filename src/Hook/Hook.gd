extends Position2D
class_name Hook, "res://assets/icons/icon_hook.svg"

onready var rayCastNode: RayCast2D = get_node("RayCast2D")
onready var arrowNode: Node2D = get_node("Arrow")
onready var snapDetectorNode: Area2D = get_node("SnapDetector")
onready var cooldownTimerNode: Timer = get_node("Cooldown")
var isActive := true


func CanHook() -> bool:
	var canHook = isActive and snapDetectorNode.HasTarget() and cooldownTimerNode.is_stopped()
	return canHook


func GetAimDirection() -> Vector2:
	var aimingDirection: Vector2 = get_local_mouse_position().normalized()
	return aimingDirection

func _ready() -> void:
	rayCastNode.cast_to.x = 300

