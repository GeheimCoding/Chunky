tool
extends Node
class_name Cache

const autoload_name := 'ChunkyCache'

var root: Node
var is_editor_mode := false
var editor_utils: EditorUtils = load('res://addons/chunky/utils/editor_utils.gd').new()

var initialized := false
var log_utils: LogUtils = load('res://addons/chunky/utils/log_utils.gd').new()


func init() -> void:
	# this assures there is only one initialization happening,
	# as this init function is called inside the _process function
	if initialized:
		return
	elif Engine.editor_hint and is_inside_tree():
		editor_init()
	elif not Engine.editor_hint:
		common_init()
	
	if initialized:
		log_utils.debug('cache initialized')


func editor_init() -> void:
	root = get_tree().get_root()
	is_editor_mode = root.has_node(autoload_name)
	
	# prevents initialization of editor_utils in case of disabled autoload
	if is_editor_mode:
		editor_utils.init(root)
		set_process(true)
		initialized = true
	else:
		common_init()


func common_init() -> void:
	# TODO: verify if _process is never needed while running the project
	set_process(false)
	initialized = true


func _process(_delta: float) -> void:
	# TODO: play around with classes and const (pass init_data?)
	init()
	# this prevents updating the editor utils, if the project runs or if
	# the plugin/autoload is disabled
	if is_editor_mode:
		editor_utils.update(root)
