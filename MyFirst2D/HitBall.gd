extends StaticBody2D

signal scoreIncrease

func randomPlace():
	
	position.x = rng.randf_range(1.0, screen_size.x)
	position.y = rng.randf_range(1.0, screen_size.y)
	print($CollisionShape2D.position)
	
	print(position)

func _resize():
	screen_size = get_viewport_rect().size

var screen_size
var rng = RandomNumberGenerator.new()

func _ready():
	get_tree().get_root().connect("size_changed", self, "_resize")
	_resize()
	rng.randomize()
	randomPlace()

func _on_Hero_hit():
	emit_signal("scoreIncrease")
	randomPlace()
	print("OK!")
	
	#$Sprite.hide()
	#$CollisionShape2D.set_deferred("disabled", true)


func _on_BtnReset_pressed():
	$Sprite.show()
	$CollisionShape2D.disabled = false
