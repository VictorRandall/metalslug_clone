extends Area2D

var dir:Vector2
var speed:float
var bullet_type:int
enum{
	pistol
	heavy_machine_gun
}

onready var sprite = get_node("Sprite")

func init(dir:Vector2, speed:float, bullet_type:int):
	self.dir = dir
	self.speed = speed
	self.bullet_type = bullet_type

func _ready():
	if dir == null or speed == null:
		assert(false, "dir or speed is null!")
	match bullet_type:
		pistol:
			sprite.frame = pistol
		heavy_machine_gun:
			sprite.frame = heavy_machine_gun
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dir == null or speed == null:
		assert(false, "dir or speed is null!")
	position += Vector2(dir.x * speed, dir.y * speed)
