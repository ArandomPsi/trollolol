extends Area2D


func _on_body_entered(body: Node2D) -> void:
	$"../ParallaxBackground/ParallaxLayer".hide()
	$"../ParallaxBackground/ParallaxLayer2".show()
