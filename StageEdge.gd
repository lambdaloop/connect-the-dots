extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var pan_amount = 1280

signal pan_camera(dx)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func get_class():
	return "StageEdge"

func _on_enter_left_body_exited(body):
	if body.get_class() == "Player" and body.position.x > position.x + $enter_left.position.x:
		emit_signal("pan_camera", pan_amount)

func _on_enter_right_body_exited(body):
	if body.get_class() == "Player" and body.position.x < position.x + $enter_right.position.x:
		emit_signal("pan_camera", -pan_amount)
