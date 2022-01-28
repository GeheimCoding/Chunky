tool
extends Node
class_name EditorUtils

var tool_button_2d: ToolButton
var file_system_dock: FileSystemDock
var tab_utils: TabUtils = load('res://addons/chunky/utils/tab_utils.gd').new()

var initialized := false
var log_utils: LogUtils = load('res://addons/chunky/utils/log_utils.gd').new()


func init(root: Node) -> void:
	# this method is called in every _process call of cache, so return early
	# if this script was already initialized
	if initialized:
		return
	init_editor(root)
	initialized = true
	log_utils.debug('editor_utils initialized')


func init_editor(root: Node) -> void:
	tab_utils.init(root)
	find_nodes_recursive(root)


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


func update(root: Node) -> void:
	# cache passes everything for init along in the update method, so that when
	# saving this script (which resets everything), it is still initialized!
	init(root)
	
	tab_utils.update(root)
