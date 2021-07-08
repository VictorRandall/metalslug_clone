extends Node
class_name Better_Anim

export(Array, NodePath) var animation_players
export(int, "String") var animations
export(int) var current_animation

var anim_state:int
var anim_attack:int
var anim_moviment:int
var transition:bool = false
var anim_finished:bool = false
