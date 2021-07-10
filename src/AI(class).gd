extends Node
class_name AI

# Declare member variables here. Examples:
export(Array) var input
export(String) var string
var motion_dir:Vector2
enum{
	throw_bomb
	stab
}
signal output(vec, action)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	emit_signal("output", motion_dir)
