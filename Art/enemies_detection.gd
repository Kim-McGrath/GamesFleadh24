extends Area2D

var enemy_count = 0 

func _on_body_entered(body):
	if body.is_in_group("slimies"):
		enemy_count += 1
		update_enemy_count()

func _on_body_exited(body):
	if body.is_in_group("slimies"):
		enemy_count -= 1
		update_enemy_count()

func update_enemy_count():
	# Here you can update a UI element or just print the count
	print("Number of enemies in area: ", enemy_count)
