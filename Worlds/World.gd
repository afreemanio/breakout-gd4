extends Node

var random_mode = true

const globalrandom = preload("res://Worlds/GlobalRandom.tres")


# Called when the node enters the scene tree for the first time.
func _ready():


	DisplayServer.window_set_title("ANDREWS BREAKOUT")
	globalrandom.random_mode_enabled = random_mode
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
