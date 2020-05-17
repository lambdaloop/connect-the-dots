extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	pass
#	if body.get_class() == "Player":
#		get_node("../../World").world_enable_portal(get_node("../Portals/Portal 4").number)
#		get_node('Label').visible = true
