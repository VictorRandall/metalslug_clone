extends KinematicBody2D

var motion:Vector2 = Vector2()
var gravity:float = 80
var speed:float = 110
var jump_height:float = 130

enum states{
	none
	
	turning
	crouching
	
	idle
	running
	jumping
	jumping_moving
	
	shooting
	stabing
	throw_bomb
}

var dir:Vector2

onready var anim:Node = get_node("AnimationPlayer")
onready var anim2:Node = get_node("AnimationPlayer2")
onready var sprite:Node = get_node("Sprite")
onready var sprite2:Node = get_node("Sprite/Sprite")

func _ready():
	pass

func _process(delta):
	#debug
	var text:String = "motion = " + str(motion) + "\nposition = " + str(position) + "\ndir = " + str(dir) + "\ncurrent anim playing (torso) = " + str(anim.current_animation) + "\ncurrent anim playing (legs) = " + str(anim2.current_animation)
	get_parent().get_node("UI/Control/Label").text = text
	
	#moviment and attack
	motion = Vector2(float(int(motion.x)),float(int(motion.y)))
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
		motion.y += gravity * delta# * delta
		if motion.x == 0:
			$BetterAnim.anim_moviment = states.jumping
		else:
			$BetterAnim.anim_moviment = states.jumping_moving
		if Input.is_action_pressed("ui_left"):
			dir = Vector2.LEFT
		elif Input.is_action_pressed("ui_right"):
			dir = Vector2.RIGHT
	
	move_and_slide_with_snap(motion, Vector2(0,10) , Vector2.UP)
