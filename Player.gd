extends KinematicBody2D


const GRAVITY = 40
const MAX_FALL_SPEED = 1000
const MOVE_SPEED = 500
const JUMP_FORCE = 650

var portal_number = null

var world = null

var dy = 0
var dx = 0

signal move_portal(number)

# Called when the node enters the scene tree for the first time.
func _ready():
	world = get_parent()
	print(world)

func _process(delta):
	dx = 0
	if Input.is_action_pressed("ui_right"):
		dx = 1
	if Input.is_action_pressed("ui_left"):
		dx = -1
	
	if portal_number != null:
		if Input.is_action_just_pressed("next_portal"):
			emit_signal("move_portal", portal_number+1)
		elif Input.is_action_just_pressed("prev_portal"):
			emit_signal("move_portal", portal_number-1)

	
func _physics_process(delta):
	move_and_slide(Vector2(dx * MOVE_SPEED, dy), Vector2(0, -1))
	
	var grounded = is_on_floor()
	if not grounded:
		dy += GRAVITY
	else:
		dy = 5

	if dy > MAX_FALL_SPEED:
		dy = MAX_FALL_SPEED
	if grounded and Input.is_action_pressed("ui_up"):
		dy = -JUMP_FORCE
		
	
func entered_portal(portal):
	print("entered portal ", portal.number)
	portal_number = portal.number

func exited_portal(portal):
	print("exited portal ", portal.number)
	if portal_number == portal.number:
		portal_number = null
