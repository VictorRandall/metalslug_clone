tool
extends Node
class_name AI
#REMOVELATER: this class will soon be useless

# Declare member variables here. Examples:
export(Array) var input
export(String) var string
var motion_dir:Vector2
enum{
	throw_bomb
	stab
}
var output_action:Array = []
signal output(action)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	emit_signal("output", output_action)
