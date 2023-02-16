extends RigidBody2D

func _ready():
	pass # Replace with function body.


func _on_Hero_hit():
	$Sprite.hide()
	$CollisionShape2D.disabled = true
	emit_signal("hit")


func _on_BtnReset_pressed():
	$Sprite.show()
	$CollisionShape2D.disabled = false
