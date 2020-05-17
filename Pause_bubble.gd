extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			get_node("Label/Timer").start()
			get_tree().paused = false
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	get_node("Label").visible = false
