extends Sprite2D


func usuremessage():
	scale = Vector2(0,0)
	visible = true
	var tween = create_tween()
	tween.tween_property(self,"scale",Vector2(1,1),1.2).set_trans(Tween.TRANS_ELASTIC)
