extends Node2D


signal enable_portal(number)
signal move_portal(number, direction)

export var number = 1
export var enabled_left = false
export var enabled_right = false
export var key_available = true

var allowed = true

# Called when the node enters the scene tree for the first time.
func _ready():
	update_ui()

func get_class():
	return "Portal"

func update_ui():
	$portal_left.visible = enabled_left
	$portal_right.visible = enabled_right
	$portal_key.visible = !enabled_left and key_available
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func activate_left():
	enabled_left = true
	update_ui()
	
func activate_right():
	enabled_right = true
	update_ui()
	

func _on_portal_key_body_entered(body):
	if $portal_key.visible and body.get_class() == "Player":
		emit_signal("enable_portal", number)

func _on_portal_right_body_entered(body):
	if allowed and enabled_right and body.get_class() == "Player":
		emit_signal("move_portal", number+1, "left")

func _on_portal_left_body_entered(body):
	if allowed and enabled_left and body.get_class() == "Player":
		emit_signal("move_portal", number-1, "right")
		
func disable_until_exit():
	allowed = false

func _on_portal_body_exited(body):
	allowed = true
