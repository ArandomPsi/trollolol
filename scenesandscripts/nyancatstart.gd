extends Area2D


func _on_body_entered(body: Node2D) -> void:
	$"../ParallaxBackground/ParallaxLayer".hide()
	$"../ParallaxBackground/ParallaxLayer2".show()
	spawnnyancat()

func spawnnyancat():
	var nyancatboss = preload("res://scenesandscripts/nyancatboss.tscn").instantiate()
	get_tree().current_scene.add_child(nyancatboss)
