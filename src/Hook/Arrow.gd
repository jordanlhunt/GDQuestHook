extends Node2D

onready var headNode: Sprite = get_node("Head")
onready var tailNode: Line2D = get_node("Tail")
onready var tweenNode: Tween = get_node("Tween")
onready var tailStartLengthOffset: float = headNode.position.x

var hookPosition: Vector2 = Vector2.ZERO setget SetHookPosition
var tailLength := 24.0 setget SetTailLength


func _unhandled_input(event: InputEvent) -> void:
	return


func SetHookPosition(value: Vector2) -> void:
	hookPosition = value
	var toTarget = hookPosition - self.global_position
	tailLength = toTarget.length()
	self.rotation = toTarget.angle()
	tweenNode.interpolate_property(
		self, "tailLength", tailLength, tailStartLengthOffset, .25, Tween.TRANS_QUAD, Tween.EASE_OUT
	)
	tweenNode.start()


func SetTailLength(value: float) -> void:
	tailLength = value
	tailNode.points[1].x = tailLength
	headNode.position.x = tailNode.points[1].x + tailNode.position.x
