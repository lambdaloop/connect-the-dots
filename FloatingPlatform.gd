extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var death_above = false
export var death_below = false

export var move_speed = 150
export var move_time = 1.0
export var wait_time = 0.3
export var offset_time = 0.1

var move_direction = -1
var wait = false

signal player_died()

# Called when the node enters the scene tree for the first time.
func _ready():
	$DeathAbove.visible = death_above
	$DeathBelow.visible = death_below
	$MoveTimer.wait_time = move_time
	$DeathZoneBelow.enabled = death_below
	$DeathZoneAbove.enabled = death_above
	$DeathZoneAbove.connect("player_died", self, "player_died")
	$DeathZoneBelow.connect("player_died", self, "player_died")
	
	$WaitTimer.wait_time = offset_time
	wait = true
	$WaitTimer.start()

func get_class():
	return "FloatingPlatform"

func player_died():
	emit_signal("player_died")

func _physics_process(delta):
	if not wait:
		position.y += move_speed * move_direction * delta
	

func _on_MoveTimer_timeout():
	move_direction *= -1
	wait = true
	$WaitTimer.start()

func _on_WaitTimer_timeout():
	$WaitTimer.wait_time = wait_time
	wait = false
	$MoveTimer.stop()
	$MoveTimer.start()
