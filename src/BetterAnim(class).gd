tool
extends Node
class_name BetterAnim

export(Array, NodePath) var anim_nodes

var anim_state:int = 0
var anim_attack:int = 0
var anim_moviment:int = 0

var anim_name:String

enum{
	start
	loop
	end
}
export(Array, int) var anim_play_state = []
export(Array, bool) var anim_finished = []

func _ready():
	for i in range(anim_nodes.size()):
		get_node(anim_nodes[i]).connect("animation_started", self, "_animation" + str(i) + "_started")
		get_node(anim_nodes[i]).connect("animation_finished", self, "_animation" + str(i) + "_finished")
#		pass

func _process(delta):
	for i in range(anim_nodes.size()):
#		pass
		if anim_attack != 0:
			anim_name = str(anim_state) + str(anim_attack)
		else:
			anim_name = str(anim_state) + str(anim_moviment)
		
		match anim_play_state[i]:
			
			start:
				if get_node(anim_nodes[i]).has_animation(anim_name + "s"):
					get_node(anim_nodes[i]).play(anim_name + "s")
					if anim_finished[i] == true:
						anim_play_state[i] = loop
			loop:
				if get_node(anim_nodes[i]).has_animation(anim_name):
					if get_node(anim_nodes[i]).is_playing():
						get_node(anim_nodes[i]).play(anim_name)
					if anim_finished[i] == true:
						anim_play_state[i] = end
			end:
				if get_node(anim_nodes[i]).has_animation(anim_name + "e"):
					get_node(anim_nodes[i]).play(anim_name + "e")

func _animation0_started(anim_name):
	anim_finished[0] = false
	print("pienspooit")

func _animation1_started(anim_name):
	anim_finished[1] = false

func _animation2_started(anim_name):
	anim_finished[2] = false

func _animation3_started(anim_name):
	anim_finished[3] = false

func _animation0_finished(anim_name):
	anim_finished[0] = true

func _animation1_finished(anim_name):
	anim_finished[1] = true

func _animation2_finished(anim_name):
	anim_finished[2] = true

func _animation3_finished(anim_name):
	anim_finished[3] = true
