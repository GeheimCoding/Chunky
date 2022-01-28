tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton(Cache.autoload_name, 'res://addons/chunky/cache.gd')


func _exit_tree():
	remove_autoload_singleton(Cache.autoload_name)
