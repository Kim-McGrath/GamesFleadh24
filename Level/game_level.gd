extends Node2D

func _ready():
	var total_nodes = count_nodes(self)
	print("Total nodes in the scene: ", total_nodes)
	
func count_nodes(node):
	if node == null : 
		return 0
	var count = 1 # Start counting with the current node
	for i in range(node.get_child_count()):
		var child = node.get_child(i)
		count = count + count_nodes(child) # Recursively count children
		return count
