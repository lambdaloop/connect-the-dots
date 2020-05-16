extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Area2D_body_entered(body):
	if body.get_class() == "Player":
		get_node("../Portals/Portal 1").visible = true
		get_node("../Portals/Portal 2").visible = true
		get_node("../../World").world_enable_portal(get_node("../Portals/Portal 2").number)
