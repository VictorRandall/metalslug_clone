extends Node
class_name BetterAnim

export(Array, NodePath) var anim_nodes

var anim_state:int = 0
var anim_attack:int = 0
var anim_moviment:int = 0

var transition:bool = false
var anim_finished:bool = false

func _ready():
	for i in range(anim_nodes.size()):
#		anim_nodes[i].connect("animation_started", self, "_animation" + str(i) + "_started")
#		anim_nodes[i].connect("animation_finished", self, "_animation" + str(i) + "_finished")
		pass

func _process(delta):
	for i in range(anim_nodes.size()):
		print(anim_nodes[i])
#		var anim_name:String
#		if anim_attack != 0:
#			anim_name = str(anim_state) + str(anim_attack)
#		else:
#			anim_name = str(anim_state) + str(anim_moviment)
#
#
#		if transition == true:
#			if anim_nodes[i].has_animation(anim_name):
#				anim_nodes[i].play(anim_name + "t")
#		else:
#			if anim_nodes[i].has_animation(anim_name):
#				anim_nodes[i].play(anim_name)
		


func _animation1_started(anim_name):
	pass

func _animation2_started(anim_name):
	pass

func _animation3_started(anim_name):
	pass

func _animation4_started(anim_name):
	pass

func _animation1_finished(anim_name):
	pass

func _animation2_finished(anim_name):
	pass

func _animation3_finished(anim_name):
	pass

func _animation4_finished(anim_name):
	pass
