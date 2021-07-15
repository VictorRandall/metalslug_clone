extends RigidBody2D


var bomb_contacts_reported:int  
var dir:Vector2
var speed:float = 15
var rotation_speed:float = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	add_force(Vector2.ZERO,Vector2.ZERO)
	

func init(dir:Vector2):
	$Area2D/CollisionShape2D.disabled = true
	self.dir = dir
	var force:Vector2 = Vector2(dir.x * speed * 8, dir.y * speed + -199)
	set_linear_velocity(force)
	if dir.x == 1:
		set_angular_velocity(rotation_speed)
	if dir.x == -1:
		set_angular_velocity(-rotation_speed)

func _process(delta):
	if bomb_contacts_reported == 2:
		var explosion = get_node("Area2D")
		explosion.get_node("CollisionShape2D").disabled = false
		yield(get_tree().create_timer(0.1), "timeout")
		queue_free()


func _on_RigidBody2D_body_entered(body):
	bomb_contacts_reported += 1


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_area_entered(area):
	if area.is_in_group("can_hit"):
		area.get_parent().hit()
