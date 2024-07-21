extends Node

var boxbroken = 0
var canleave = false
func getboxcount():
	var count = 0
	var nodes = get_tree().current_scene.get_children()
	for i in nodes:
		if i.is_in_group('box'):
			count += 1
	return count

func reset():
	boxbroken = 0 
	canleave = false
