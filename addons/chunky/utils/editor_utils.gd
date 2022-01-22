tool
extends Node

var tabs: Tabs
var tool_button_2d: ToolButton
var file_system_dock: FileSystemDock


func find_nodes(root):
	find_nodes_recursive(root)


func find_nodes_recursive(node: Node) -> void:
	# early return saves about a factor of 10 node traversals
	if tabs and tool_button_2d and file_system_dock:
		return
	
	for child in node.get_children():
		# prevents user nodes to override the editor nodes
		# editor nodes will always be encountered first
		if child is Tabs and not tabs:
			tabs = child
		elif child.name == "2D" and not tool_button_2d:
			tool_button_2d = child
		elif child.name == "FileSystem" and not file_system_dock:
			file_system_dock = child
		
		find_nodes_recursive(child)
