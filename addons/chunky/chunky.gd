tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("ChunkyCache", "res://addons/chunky/cache.gd")


func _exit_tree():
	remove_autoload_singleton("ChunkyCache")
