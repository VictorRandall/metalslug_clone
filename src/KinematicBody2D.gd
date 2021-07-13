extends KinematicBody2D

#FIXME: fix the jumping animation problem
#TODO: make him have all types of attack
#TODO: make the player attack enemys and get hit
#TODO: make the player be able to enter veicles and use them


var motion:Vector2 = Vector2()
var gravity:float = 150
var jump_height:float = 180
var speed:float = 110

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
var dir:Vector2 = Vector2.RIGHT
const NORM_SPRITE_HEIGHT = -23

onready var BA:Node = get_node("BetterAnim")
onready var anim:Node = get_node("BetterAnim/AP")
onready var anim2:Node = get_node("BetterAnim/AP2")
onready var sprite:Node = get_node("Sprite")
onready var sprite2:Node = get_node("Sprite/Sprite")

export(float) var sprite_height

signal text_update(text)

func _ready():
	pass

func shoot():
	var bullet_scene = preload("res://assets/scenes/bullet.tscn")
	var bullet = bullet_scene.instance()
	bullet.init(dir, 10, 0)
	get_parent().add_child(bullet)
	bullet.position = get_node("Sprite/Position2D").global_position

func _process(delta):
	#debug
	var text:String = "motion = " + str(motion) + "\nposition = " + str(position) + "\ndir = " + str(dir) + "\ncurrent anim playing (torso) = " + str(anim.current_animation) + "\ncurrent anim playing (legs) = " + str(anim2.current_animation) + "\nanim state = " + str(BA.anim_state) + "\nanim torso = " + str(BA.anim_2part) + "\nanim leg = " + str(BA.anim_part)
	emit_signal("text_update", text)
	
	#moviment
#	motion = Vector2(float(int(motion.x)),float(int(motion.y)))
#	position = Vector2(float(int(position.x)),float(int(position.y)))
	var motion_dir:Vector2
	if Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") != 0:
		motion_dir = Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 0)
	else:
		motion_dir = Vector2(0, Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down"))
#	print(motion_dir)
	if motion_dir.x != 0:
#		if Input.is_action_pressed("ui_up"):
#			dir = Vector2.UP
#		elif Input.is_action_pressed("ui_down"):
#			dir = Vector2.DOWN
		dir = motion_dir
		
		if is_on_floor():
			BA.anim_part = states.running
			sprite.scale.x = motion_dir.x
			sprite.position.x = 2.5 * motion_dir.x + motion_dir.x
			sprite.position.y = float(NORM_SPRITE_HEIGHT) - sprite_height
	else:
		if is_on_floor():
			BA.anim_part = states.idle
		sprite.position.y = float(NORM_SPRITE_HEIGHT) - sprite_height
	
	if is_on_floor():
		motion.x = motion_dir.x * speed
		motion.y = 0
		if Input.is_action_pressed("ui_jump"):
#			motion.y = 0
			motion.y -= jump_height
			
	else:
		if motion.x == 0:
			BA.anim_part = states.jumping
		else:
			BA.anim_part = states.jumping_moving
		motion.x += motion_dir.x * speed * delta
		motion.y += gravity * delta
	#attack
	if Input.is_action_pressed("ui_shoot"):
		BA.anim_part = states.shooting
#	elif Input.is_action_pressed("ui_stab"):
	
	move_and_slide_with_snap(motion, Vector2(0,4) , Vector2.UP)
