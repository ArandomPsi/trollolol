extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if global.nyancatboss_defeated: return
	if "angry" in name:
		global.nyancatboss.atktime /= 2
		var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		tween.tween_property($"../nyancatangry/flash/ColorRect", "modulate:a", 0.7, 0.2)
		tween.tween_property($"../nyancatangry/flash/ColorRect", "modulate:a", 0.0, 0.2)
		await tween.finished
		queue_free()
		return
	if "end" in name:
		$"../player".SPEED = 120.0
		$"../player".space = false
		global.nyancatboss.die()
		queue_free()
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
