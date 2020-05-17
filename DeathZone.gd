extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var enabled = true

signal player_died()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_class():
	return "DeathZone"

func _on_Area2D_body_entered(body):
	if body.get_class() == "Player" and enabled:
		emit_signal("player_died")
