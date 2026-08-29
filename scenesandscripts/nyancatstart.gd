extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if "angry" in name:
		global.nyancatboss.atktime /= 2
		var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		tween.tween_property($"../nyancatangry/flash/ColorRect", "modulate:a", 1.0, 0.2)
		tween.tween_property($"../nyancatangry/flash/ColorRect", "modulate:a", 0.0, 0.2)
		await tween.finished
		return
	$"../ParallaxBackground/ParallaxLayer".hide()
	$"../ParallaxBackground/ParallaxLayer2".show()
	$"../player".space = true
	spawnnyancat()
	$"../player".global_position = $Marker2D.global_position
	$"../player".SPEED = 60.0
	queue_free()

func spawnnyancat():
	var nyancatboss = preload("res://scenesandscripts/nyancatboss.tscn").instantiate()
	get_tree().current_scene.add_child(nyancatboss)
	nyancatboss.cam = $"../player".get_node("Camera2D")
	global.nyancatboss = nyancatboss
