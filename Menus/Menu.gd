extends Control
#extends Node

var world = "res://Worlds/World.tscn"

func _ready():
	visible = false

func _on_restart_button_pressed():
	get_tree().change_scene_to_file(world)
	pass # Replace with function body.
