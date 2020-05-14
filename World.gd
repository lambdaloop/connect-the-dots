extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var portal_dict = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for portal in $Portals.get_children():
		if portal.get_class() == "Portal":
			portal_dict[portal.number] = portal
			portal.connect("move_portal", self, "player_move_portal")
			portal.connect("enable_portal", self, "world_enable_portal")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func world_enable_portal(number):
	portal_dict[number].activate_left()
	if number-1 in portal_dict:
		portal_dict[number-1].activate_right()

func player_move_portal(number, direction):
	print("move to ", number)
	if not (number in portal_dict):
		return
	var p = portal_dict[number]
	if direction == "left":
		if p.enabled_left:
			p.disable_until_exit()
			$Player.position = p.position 
			$Player.translate(Vector2(-24, 4))
			$Player.flip_dy()
	elif direction == "right":
		if p.enabled_right:
			p.disable_until_exit()
			$Player.position = p.position
			$Player.translate(Vector2(24, 4))
			$Player.flip_dy()

