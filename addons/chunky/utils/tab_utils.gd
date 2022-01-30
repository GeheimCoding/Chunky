tool
extends Node
class_name TabUtils

var editor_tabs: Tabs
var tabs := []
var tab_idx := 0
var tab_count := 0
var tab_title := ''

var initialized := false
var log_utils: LogUtils = load('res://addons/chunky/utils/log_utils.gd').new()


func init(init_data: InitData) -> void:
	# this method is called in every _process call of cache, so return early
	# if this script was already initialized
	if initialized:
		return
	find_tabs(init_data.root)
	initialized = true
	log_utils.debug('tab_utils.gd initialized')


func find_tabs(root: Node) -> void:
	find_tabs_recursive(root)


func find_tabs_recursive(node: Node) -> void:
	# early return saves about a factor of 10 node traversals
	if editor_tabs:
		return
	
	for child in node.get_children():
		# prevents user nodes to override the editor nodes
		# editor nodes will always be encountered first
		if child is Tabs and not editor_tabs:
			editor_tabs = child
			return
		
		find_tabs_recursive(child)


func update(init_data: InitData) -> void:
	# cache passes everything for init along in the update method, so that when
	# saving this script (which resets everything), it is still initialized!
	init(init_data)
	update_tabs()


func update_tabs() -> void:
	var updated_tab_idx := editor_tabs.current_tab
	var updated_tab_count := editor_tabs.get_tab_count()
	var updated_tab_title := editor_tabs.get_tab_title(updated_tab_idx)
	var updated_tabs := []
	for tab_idx in range(updated_tab_count):
		updated_tabs.append(editor_tabs.get_tab_title(tab_idx))

	handle_tab_updates(updated_tab_idx, updated_tab_count, updated_tab_title, updated_tabs)

	tabs = updated_tabs
	tab_idx = updated_tab_idx
	tab_count = updated_tab_count
	tab_title = updated_tab_title


func handle_tab_updates(updated_tab_idx: int, updated_tab_count: int, updated_tab_title: String, updated_tabs: PoolStringArray) -> void:
	# TODO: implement when needed
	pass
