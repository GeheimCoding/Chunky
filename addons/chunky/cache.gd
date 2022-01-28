tool
extends Node
class_name Cache

const autoload_name := 'ChunkyCache'

var root: Node
var editor_utils: EditorUtils = load('res://addons/chunky/utils/editor_utils.gd').new()

var initialized := false


func init():
	if initialized:
		return
	if Engine.editor_hint and is_inside_tree():
		init_editor_utils()
		initialized = true
		print('cache initialized')


func init_editor_utils():
	root = get_tree().get_root()
	editor_utils.init(root)


func _process(_delta: float):
	# TODO: tidy up / disable process when not in editor mode?
	# TODO: play around with classes and const (pass init_data?)
	# TODO: add log_utils with debug/info/warn/error + const flags?
	init()
	# this prevents updating the editor utils, if the actual game runs or if
	# the plugin/autoload is disabled
	if root and root.has_node(autoload_name):
		editor_utils.update(root)
