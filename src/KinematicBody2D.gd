extends KinematicBody2D

var motion:Vector2 = Vector2()
var gravity:float = 80
var speed:float = 110
var jump_height:float = 130

var anim_state:int
var anim_attack:int
var anim_moviment:int
var transition:bool = false
var anim_finished:bool = false
var is_falling:bool = false
enum States{
	none
	
	idle
	running
	jumping
	jumping_moving
	stop
	
	turning
	crouching
	dead
	
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
	var text:String = "motion = " + str(motion) + "\nposition = " + str(position) + "\nanim_state = " + str(anim_state) + "\nanim_attack = " + str(anim_attack) + "\nanim_moviment = " + str(anim_moviment) + "\ntransition = " + str(transition) + "\nanim finished = " + str(anim_finished) + "\nis falling = " + str(is_falling) + "\ndir = " + str(dir) + "\ncurrent anim playing (torso) = " + str(anim.current_animation) + "\ncurrent anim playing (legs) = " + str(anim2.current_animation)
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
			anim_moviment = running
			sprite.scale.x = motion_dir
			sprite.position.x = 2.5 * motion_dir + motion_dir
		else:
			anim_moviment = idle
			
	else:
		motion.y += gravity * delta# * delta
		if motion.x == 0:
			anim_moviment = jumping
		else:
			anim_moviment = jumping_moving
		if Input.is_action_pressed("ui_left"):
			dir = Vector2.LEFT
		elif Input.is_action_pressed("ui_right"):
			dir = Vector2.RIGHT
	
	move_and_slide_with_snap(motion, Vector2(0,10) , Vector2.UP)
	
	
	
	#animations
#	match anim_state:
#		turning:
#			sprite2.visible = false
#		crouching:
#			sprite2.visible = false
#		none:
#			sprite2.visible = true
#	match anim_attack:
#		shooting:
#			pass
##			anim.play(str(anim_attack))
#		stabing:
#			pass
##			anim.play(str(anim_attack))
#		throw_bomb:
#			pass
##			anim.play(str(anim_attack))
#		none:
#			pass
#	match anim_moviment:
#		idle:
#			if anim_state == none or anim_attack == none:
#				anim.play(str(anim_moviment))
#			sprite.position.y = -23
#			anim2.play(str(anim_moviment))
#		running:
#			if anim_state == none or anim_attack == none:
#				anim.play(str(anim_moviment))
#			sprite.position.y = -26
##				anim.current_animation_position = anim2.current_animation_position
#			anim2.play(str(anim_moviment))
#		jumping:
##			var anim_speed:float = motion.y * 0.15 * -1
##			if anim2.current_animation_position == anim2.current_animation_position - anim2.current_animation_length:
##			print(anim2.current_animation_position - anim2.current_animation_length)
#			if anim_state == none or anim_attack == none:
#				anim.play(str(anim_moviment))
#			anim2.play(str(anim_moviment))
#		jumping_moving:
#			if anim_state == none or anim_attack == none:
##				pass
#				anim.play(str(anim_moviment))
#			anim2.play(str(anim_moviment))


func _animation_finished(anim_name):
#	if anim.current_animation == 
	anim_finished = true
#	if anim_state != none:
#		anim_state = none
#	if anim_attack != none:
#		anim_attack = none
	


func _animation_started(anim_name):
	anim_finished = false
#	print(finished)
