extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var id = 0


signal entered_checkpoint(id)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_class():
	return "Checkpoint"

func _on_Checkpoint_body_entered(body):
	emit_signal("entered_checkpoint", id)
