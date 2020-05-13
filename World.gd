extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var portal_dict = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.connect("move_portal", self, "player_move_portal")
	for portal in $Portals.get_children():
		if portal.get_class() == "Portal":
			portal_dict[portal.number] = portal

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func player_move_portal(number):
	print("move to ", number)
	if number in portal_dict:
		var p = portal_dict[number]
		if p.enabled:
			$Player.position = p.position
