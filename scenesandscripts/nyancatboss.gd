extends Node2D

var tracking : bool = true
var moving : bool = true
var atktimer : float = 0.0

func _process(delta: float) -> void:
	global_position.x = lerp(global_position.x,global.playerpos.x - 450.0,0.15)
	if tracking: 
		global_position.y = lerp(global_position.y,global.playerpos.y,0.1)
		atktimer += delta
	if moving:
		for rainbow in $trail.get_children():
			rainbow.position.x += 7
			if rainbow.position.x >= 125.0:
				rainbow.position.x = -1210.0
	if atktimer >= 5.0:
		readyup()
		atktimer = 0.0

func tween():
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "global_position:x", global_position.x + 1306.0, 0.6)
	moving = false
	for i in range($trail.get_children().size()):
		tween.parallel().tween_property($trail.get_child($trail.get_children().size() - i - 1), "modulate:a", 0.0, 0.8).set_delay(i * 0.05)
	tween.tween_property(self, "global_position:x", global_position.x - 1306.0, 0.8)
	await tween.finished
	moving = true
	for rainbow in $trail.get_children():
		rainbow.modulate.a = 1.0
		
func readyup():
	tracking = false
	$path.show()
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	for i in range(3):
		tween.tween_property($path, "modulate:a", 1.0, 0.5)
		tween.tween_property($path, "modulate:a", 0.0, 0.5)
	await tween.finished
	$path.hide()
	await tween()
	tracking = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.die()
