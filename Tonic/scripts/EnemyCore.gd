extends Sprite

export(int) var speed = 75
export(int) var hp = 3
export(int) var knock_back = 600
export(int) var screen_shake = 120
export(int) var score = 10

var velocity = Vector2()
var stun = false

var blood_particles = preload("res://scenes/BloodParticles.tscn")

onready var current_color = modulate

func _process(_delta):
	if hp <= 0:
		if Global.camera != null:
			Global.camera.screen_shake(screen_shake, 0.3)
		Global.score += score
		if Global.node_creation_parent != null:
			var blood_particles_instance = Global.instance_node(blood_particles, global_position, Global.node_creation_parent)
			blood_particles_instance.rotation = velocity.angle()
		queue_free()
	pass

func basic_movement(delta):
	if Global.player != null and !stun:
		velocity = global_position.direction_to(Global.player.global_position)
		global_position += velocity * speed * delta
	elif stun:
		velocity = lerp(velocity, Vector2(0,0), 0.3)
		global_position += velocity * delta
	pass	

func _on_HitBox_area_entered(area):
	if area.is_in_group("enemy_damager") and !stun:
		Input.vibrate_handheld(500)
		modulate = Color.white
		velocity = - velocity * knock_back
		if hp > 1 :
			Global.camera.screen_shake(10, 0.05)
		hp -= 1
		stun = true
		$StunTimer.start()
		area.get_parent().queue_free()
pass

func _on_StunTimer_timeout():
	modulate = current_color
	stun = false
	pass
