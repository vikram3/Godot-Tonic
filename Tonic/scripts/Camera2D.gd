extends Camera2D

var screen_shake_start = false
var shake_intensity = 0

func _ready():
	Global.camera = self
	pass
	
func _exit_tree():
	Global.camera = null
	pass

func _process(delta):
	zoom = lerp(zoom, Vector2(1, 1), 0.3)

	if screen_shake_start:
		global_position += Vector2(rand_range(-shake_intensity, shake_intensity),
								   rand_range(-shake_intensity, shake_intensity)) * delta
								
								
	else:
		global_position = lerp(global_position, Vector2(320, 180), 0.3)
	pass
	
	
	
func screen_shake(intensity, time):
	zoom = Vector2(1, 1) - Vector2(intensity * 0.0015, intensity * 0.0015) 
	shake_intensity = intensity
	$ScreenShakeTimer.wait_time = time
	$ScreenShakeTimer.start()
	screen_shake_start = true
	pass


func _on_ScreenShakeTimer_timeout():
	screen_shake_start = false
	pass
