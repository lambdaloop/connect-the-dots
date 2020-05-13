extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var number = 1
export var enabled = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Portal_body_entered(body):
	if body.get_name() == "Player":
		body.entered_portal(self)


func _on_Portal_body_exited(body):
	if body.get_name() == "Player":
		body.exited_portal(self)

func get_class():
	return "Portal"
