extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var pan_amount = 1280

signal pan_camera(dx)

var allowed = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func get_class():
	return "StageEdge"


func _on_enter_body_entered(body):
	if body.get_class() == "Player":
		if body.position.x < position.x + $enter.position.x:
			emit_signal("pan_camera", pan_amount)
		else:
			emit_signal("pan_camera", -pan_amount)
		allowed = false
			
func _on_enter_body_exited(body):
	if body.get_class() == "Player":
		if body.position.x < $"../Camera2D".position.x:
			emit_signal("pan_camera", -pan_amount)
		elif body.position.x > $"../Camera2D".position.x + 1280:
			emit_signal("pan_camera", pan_amount) 
