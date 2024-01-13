extends "res://Menus/Menu.gd"
@onready var audio_player = $AudioStreamPlayer


func _on_ball_game_over():
	audio_player.play(0)
	visible = true
	pass # Replace with function body.


