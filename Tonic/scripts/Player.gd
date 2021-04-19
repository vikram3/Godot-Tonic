extends Sprite

var speed = 175
var velocity = Vector2()
var can_shoot = true
var is_dead = false

var bullet = preload("res://scenes/Bullet.tscn")
onready var joystick = get_parent().get_node("Joystick/Sprite/TouchScreenButton")
onready var joystick2 = get_parent().get_node("Joystick2/Sprite/TouchScreenButton")


func _ready():
	Global.player = self
	pass

func _exit_tree():
	Global.player = null
	pass

func _process(delta):

	velocity.x = joystick.get_value().x
	velocity.y = joystick.get_value().y
	rotation = joystick.get_value().angle()
	
	velocity = velocity.normalized()
	
	global_position.x = clamp(global_position.x, 10, 630)
	global_position.y = clamp(global_position.y, 10, 350)
	if !is_dead:
		global_position += velocity * speed * delta
	
	
	if joystick2.get_value() and Global.node_creation_parent != null and can_shoot and !is_dead:
		Global.instance_node(bullet, global_position, Global.node_creation_parent)
		$ReloadTimer.start()
		can_shoot = false
	pass


func _on_ReloadTimer_timeout():
	can_shoot = true
	pass


func _on_HitBox_area_entered(area):
	if area.is_in_group("enemy"):
		Input.vibrate_handheld(500)
		visible = false
		is_dead = true
		if Global.is_first_round:
			Global.is_first_round = false
		yield(get_tree().create_timer(1),"timeout")
		get_tree().reload_current_scene()
	pass
