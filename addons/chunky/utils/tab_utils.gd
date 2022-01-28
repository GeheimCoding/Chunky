tool
extends Node
class_name TabUtils

var tabs: Tabs
var tab_idx := 0
var tab_count := 0
var tab_title := ''

var initialized := false
var log_utils: LogUtils = load('res://addons/chunky/utils/log_utils.gd').new()


func init(root: Node) -> void:
	# this method is called in every _process call of cache, so return early
	# if this script was already initialized
	if initialized:
		return
	find_tabs(root)
	initialized = true
	log_utils.debug('tab_utils initialized')


func find_tabs(root: Node) -> void:
	find_tabs_recursive(root)


func find_tabs_recursive(node: Node) -> void:
	# early return saves about a factor of 10 node traversals
	if tabs:
		return
	
	for child in node.get_children():
		# prevents user nodes to override the editor nodes
		# editor nodes will always be encountered first
		if child is Tabs and not tabs:
			tabs = child
			return
		
		find_tabs_recursive(child)


func update(root: Node) -> void:
	# cache passes everything for init along in the update method, so that when
	# saving this script (which resets everything), it is still initialized!
	init(root)
	
	var current_tab_idx := tabs.current_tab
	var current_tab_count := tabs.get_tab_count()
	var current_tab_title := tabs.get_tab_title(current_tab_idx)
	var current_tabs := []
	for tab_idx in range(current_tab_count):
		current_tabs.append(tabs.get_tab_title(tab_idx))

	# update cache titles in case of any tabs with same names were added
	if current_tab_count > tab_count:
		handle_opened_tabs(current_tabs)
	
	# if the current tab did not change, but the title did,
	# update cache with same scene as before or invalidate scene if unsaved
	if current_tab_count == tab_count:
		handle_current_tab(current_tab_idx, current_tab_title)
	
	# some tabs were closed, invalidate caches of unsaved scenes
	if current_tab_count < tab_count:
		handle_closed_tabs(current_tabs, current_tab_title)

	tab_idx = current_tab_idx
	tab_count = current_tab_count
	tab_title = current_tab_title


func handle_opened_tabs(current_tabs: PoolStringArray) -> void:
	pass


func handle_current_tab(current_tab_idx: int, current_tab_title: String) -> void:
	pass


func handle_closed_tabs(current_tabs: PoolStringArray, current_tab_title: String) -> void:
	pass
