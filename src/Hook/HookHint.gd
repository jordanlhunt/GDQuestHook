tool
extends Position2D

export var fillColor: Color
export var defaultRadius := 10.0


func _draw() -> void:
	draw_circle(Vector2.ZERO, defaultRadius, fillColor)
	self.update()


func _ready() -> void:
	set_as_toplevel(true)
