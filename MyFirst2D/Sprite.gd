extends Area2D

signal hit

var speed = 400
var angular_speed = PI

func _ready():
	get_tree().get_root().connect("size_changed", self, "_resize")
	screen_size = get_viewport_rect().size
	position = screen_size * 0.5

func _resize():
	screen_size = get_viewport_rect().size
var screen_size

func _process(delta):
	var dir = 0
	if Input.is_action_pressed("rote_left"):
		dir = -1
	if Input.is_action_pressed("rote_right"):
		dir = 1
	rotation += angular_speed * dir * delta

	var v2 = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		v2 = Vector2.UP.rotated(rotation) * speed
	if Input.is_action_pressed("move_down"):
		v2 = Vector2.DOWN.rotated(rotation) * speed
	position += v2 * delta
	adjust_pos()

func adjust(x: float, minV: float, maxV: float) -> Array:
	if x < minV:
		return [true, minV]
	if x > maxV:
		return [true, maxV]
	return [false, x]

func adjust_pos():
	var x = adjust(position.x, 0, screen_size.x)
	position.x = x[1]
	var y = adjust(position.y, 0, screen_size.y)
	position.y = y[1]
	if x[0] or y[0]:
		rotation += PI

func _on_reset():
	position = screen_size * 0.5
	rotation = 0

func _on_visible():
	visible = not visible


func _on_hero_body_entered(body):
	emit_signal("hit")
