extends KinematicBody2D

var motion:Vector2 = Vector2()
var gravity:float = 2
var speed:float = 110
var jump_height:float = 130

enum states{
	none #0
	
	idle #1
	running #2
	jumping #3
	jumping_moving #4
	stop #5
	
	shooting #6
	stabing #7
	throw_bomb #8
	
	turning #9
	crouching #10
}

var dir:Vector2

onready var BA:Node = get_node("BetterAnim")
onready var anim:Node = get_node("BetterAnim/AP")
onready var anim2:Node = get_node("BetterAnim/AP2")
onready var sprite:Node = get_node("Sprite")
onready var sprite2:Node = get_node("Sprite/Sprite")

func _ready():
	pass

func _process(delta):
	#debug
	var text:String = "motion = " + str(motion) + "\nposition = " + str(position) + "\ndir = " + str(dir) + "\ncurrent anim playing (torso) = " + str(anim.current_animation) + "\ncurrent anim playing (legs) = " + str(anim2.current_animation) + "\nanim state = " + str(BA.anim_state) + "\nanim attack = " + str(BA.anim_attack) + "\nanim moviment = " + str(BA.anim_moviment)
	get_parent().get_node("UI/Control/Label").text = text
	
	#moviment and attack
	motion = Vector2(float(int(motion.x)),float(int(motion.y)))
#	position = Vector2(float(int(position.x)),float(int(position.y)))
	var motion_dir:float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if is_on_floor():
		motion.x = motion_dir * speed
		motion.y -= 0
		if Input.is_action_pressed("ui_jump"):
			motion.y = 0
			motion.y -= jump_height
		if motion_dir != 0:
			if Input.is_action_pressed("ui_up"):
				dir = Vector2.UP
			elif Input.is_action_pressed("ui_down"):
				dir = Vector2.DOWN
			$BetterAnim.anim_moviment = states.running
			sprite.scale.x = motion_dir
			sprite.position.x = 2.5 * motion_dir + motion_dir
		else:
			$BetterAnim.anim_moviment = states.idle
	else:
		motion.y += gravity# * delta# * delta
		if motion.x == 0:
			$BetterAnim.anim_moviment = states.jumping
		else:
			$BetterAnim.anim_moviment = states.jumping_moving
		if Input.is_action_pressed("ui_left"):
			dir = Vector2.LEFT
		elif Input.is_action_pressed("ui_right"):
			dir = Vector2.RIGHT
	
	move_and_slide_with_snap(motion, Vector2(0,10) , Vector2.UP)
