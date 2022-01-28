tool
extends Node
class_name LogUtils

enum {INFO = 0, DEBUG = 1, TRACE = 2}
const log_level := INFO


func info(args) -> void:
	print_args(INFO, args)


func debug(args) -> void:
	print_args(DEBUG, args)


func trace(args) -> void:
	print_args(TRACE, args)


func warn(args) -> void:
	push_warning(prepare_message(args))


func error(args) -> void:
	push_error(prepare_message(args))


func print_args(needed_log_level: int, args) -> void:
	if log_level >= needed_log_level:
		print(prepare_message(args))


func prepare_message(args) -> String:
	# the different log methods can also be called with a single argument
	if typeof(args) != TYPE_ARRAY:
		args = [args]
	
	var message := ''
	for arg in args:
		message += str(arg)
	return message
