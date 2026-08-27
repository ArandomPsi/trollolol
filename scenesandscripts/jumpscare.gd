extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if randi_range(0, 100) >= 25:
		queue_free()
	await get_tree().create_timer(randf_range(0.5, 5.0)).timeout
	create_jumpscare()
	queue_free()
	
func create_jumpscare():
	var jumpscare = preload("res://scenesandscripts/verityjumpscare.tscn").instantiate()
	get_parent().add_child(jumpscare)
