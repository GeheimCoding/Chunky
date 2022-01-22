tool
extends Node

var editor_utils = load("res://addons/chunky/utils/editor_utils.gd").new()


func _init():
	editor_utils.find_nodes(get_tree().get_root())
