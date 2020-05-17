extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var PortalLine = load("res://PortalLine.tscn")

const PORTAL_OFFSET = 32

var portal_dict = {}
var lines_dict = {} # key for a line from portal N-1 to N is N
var checkpoints = {}


var checkpoint_id = 0

func setup_portal(portal):
	portal_dict[portal.number] = portal
	portal.connect("move_portal", self, "player_move_portal")
	portal.connect("enable_portal", self, "world_enable_portal")
	
func update_line_points(pnum):
	var line = lines_dict[pnum]
	var p1 = portal_dict[pnum-1]
	var p2 = portal_dict[pnum]
	line.points = PoolVector2Array([
		p1.global_position + Vector2(PORTAL_OFFSET, 0),
		p2.global_position - Vector2(PORTAL_OFFSET, 0)
	])
	line.visible = p2.enabled_left
	
# Called when the node enters the scene tree for the first time.
func _ready():
	for portal in $Portals.get_children():
		if portal.get_class() == "Portal":
			setup_portal(portal)

	for zone in get_children():
		if zone.get_class() == "FloatingPlatform":
			for x in zone.get_children():
				if x.get_class() == "Portal":
					setup_portal(x)

	
	for pnum in portal_dict.keys():
		if pnum-1 in portal_dict:
			var line = PortalLine.instance()
			add_child(line)
			lines_dict[pnum] = line
			update_line_points(pnum)

	for edge in $Edges.get_children():
		if edge.get_class() == 'StageEdge':
			edge.connect("pan_camera", self, "pan_camera")
			
	for zone in get_children():
		if zone.get_class() == "DeathZone" or zone.get_class() == "FloatingPlatform":
			zone.connect("player_died", self, "player_death")
			
	var id = 0
	for checkpoint in $Checkpoints.get_children():
		if checkpoint.get_class() == "Checkpoint":
			checkpoint.id = id
			checkpoint.connect("entered_checkpoint", self, "set_checkpoint")
			checkpoints[id] = checkpoint
			id += 1
	#$Camera2D.move_local_x(1280)
	
	move_camera_to_player()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for pnum in lines_dict.keys():
		update_line_points(pnum)

func player_death():
	print("YOU DEADDD")
	$Player.position = checkpoints[checkpoint_id].position
	$Player.reset_velocity()
	move_camera_to_player()

func set_checkpoint(id):
	print("entered checkpoint " + str(id))
	checkpoint_id = id
	
func move_camera_to_player():
	$Camera2D.position.x = floor($Player.position.x / 1280) * 1280

func pan_camera(dx):
	$Camera2D.move_local_x(dx)

func world_enable_portal(number):
	portal_dict[number].activate_left()
	if number-1 in portal_dict:
		portal_dict[number-1].activate_right()
		lines_dict[number].visible = true

func player_move_portal(number, direction):
	print("move to ", number)
	if not (number in portal_dict):
		return
	var before = $Player.position.x
	var p = portal_dict[number]
	if direction == "left":
		if p.enabled_left:
			p.disable_until_exit()
			$Player.position = p.global_position 
			$Player.translate(Vector2(-42, 4))
			$Player.flip_dy()
	elif direction == "right":
		if p.enabled_right:
			p.disable_until_exit()
			$Player.position = p.global_position
			$Player.translate(Vector2(42, 4))
			$Player.flip_dy()
			
	var after = $Player.position.x
	$Camera2D.position.x = floor($Player.position.x / 1280) * 1280
		

