extends Label

func _ready():
	text = "Highscore: %s" % String(Global.high_score)
	pass

func _process(delta):
	Global.high_score = Global.score if Global.score > Global.high_score else Global.high_score
	pass


func _on_TextureButton_pressed():
	Input.vibrate_handheld(500)
	get_tree().change_scene("res://scenes/Arena.tscn")
