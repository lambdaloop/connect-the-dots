extends KinematicBody2D


const GRAVITY = 40
const MAX_FALL_SPEED = 1250
const JUMP_FORCE = 650

const MOVE_MAX_SPEED = 600
const MOVE_SLOWDOWN = 0.8
const MOVE_FORCE = 50

var portal_number = null

var world = null

var dy = 0
var dx = 0

var grounded_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	world = get_parent()
	print(world)

func _process(delta):
	$Sprite.set_scale(Vector2(
		1.75 - 0.3*abs(dx)/MOVE_MAX_SPEED - 0.3*abs(dy)/MAX_FALL_SPEED, 
		1.75 ))
	
func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		dx +=  MOVE_FORCE 
	elif Input.is_action_pressed("ui_left"):
		dx += -MOVE_FORCE
	else:
		dx *= MOVE_SLOWDOWN
	
	if abs(dx) > MOVE_MAX_SPEED:
		dx = MOVE_MAX_SPEED * sign(dx)
		
	move_and_slide(Vector2(dx, dy), Vector2(0, -1))
	
	
	
	var grounded = is_on_floor()
	if not grounded:
		dy += GRAVITY
		grounded_time = 0
		
	if grounded:
		grounded_time += delta
		if grounded_time > 0.1:
			dy = 5

	if dy > MAX_FALL_SPEED:
		dy = MAX_FALL_SPEED
	if grounded and Input.is_action_pressed("ui_up"):
		dy = -JUMP_FORCE
		
	
func get_class():
	return "Player"

func flip_dy():
	dy = -dy
	
func reset_velocity():
	dx = 0
	dy = 0
