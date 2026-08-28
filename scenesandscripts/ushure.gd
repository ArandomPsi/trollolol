extends Sprite2D


func usuremessage():
	scale = Vector2(0,0)
	visible = true
	var tween = create_tween()
	tween.tween_property(self,"scale",Vector2(1,1),1.2).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT_IN)
	tween.parallel().tween_property(self,"rotation",TAU,1).set_trans(Tween.TRANS_ELASTIC)
