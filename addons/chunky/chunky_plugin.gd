tool
extends EditorPlugin


func _enter_tree() -> void:
	add_autoload_singleton(Chunky.autoload_name, 'res://addons/chunky/chunky.gd')


func _exit_tree() -> void:
	remove_autoload_singleton(Chunky.autoload_name)
