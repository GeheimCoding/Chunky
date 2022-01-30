tool
extends Node
class_name EditorUtils

var tool_button_2d: ToolButton
var file_system_dock: FileSystemDock
var tab_utils: TabUtils = load('res://addons/chunky/utils/tab_utils.gd').new()

var initialized := false
var log_utils: LogUtils = load('res://addons/chunky/utils/log_utils.gd').new()


func init(init_data: InitData) -> void:
	# this method is called in every _process call of cache, so return early
	# if this script was already initialized
	if initialized:
		return
	init_editor(init_data)
	initialized = true
	log_utils.debug('editor_utils.gd initialized')


func init_editor(init_data: InitData) -> void:
	tab_utils.init(init_data)
	find_nodes_recursive(init_data.root)


func find_nodes_recursive(node: Node) -> void:
	# early return saves about a factor of 10 node traversals
	if tool_button_2d and file_system_dock:
		return
	
	for child in node.get_children():
		# prevents user nodes to override the editor nodes
		# editor nodes will always be encountered first
		if child.name == '2D' and not tool_button_2d:
			tool_button_2d = child
		elif child.name == 'FileSystem' and not file_system_dock:
			file_system_dock = child
		
		find_nodes_recursive(child)


func update(init_data: InitData) -> void:
	# cache passes everything for init along in the update method, so that when
	# saving this script (which resets everything), it is still initialized!
	init(init_data)
	tab_utils.update(init_data)
