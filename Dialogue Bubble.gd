extends Node2D

var counts_elapsed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			get_node("Label/Timer").start()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	counts_elapsed += 1
	if counts_elapsed >= 1:
		get_node('Label').text = ""
	if counts_elapsed >= 2:
		get_node('Label').text = "Sometimes, the platforms are too high. \nUse portals to reach them!"
	if counts_elapsed >= 3:
		get_node('Label').text = ""
