extends Node2D

var tracking : bool = true
var moving : bool = true
var start : bool = false
var atktimer : float = 0.0
var atktime : float = 3.5
var cam : Camera2D
var offset : float = 150.0

func _ready() -> void:
	get_tree().paused = true
	$Panel.visible = true
	$Panel.modulate.a = 0.0
	$Panel/Label.text = "~ I'm done being a background character! meow meow meow nyaw ~"
	$Panel.position.y += 100
	var tween = create_tween()
	tween.tween_property($Panel,"position:y",-225.0,0.5).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property($Panel,"modulate:a",1.0,0.5)
	tween.tween_property($Panel/Label,"visible_ratio",1.0,0.8)
	tween.tween_interval(3)
	tween.tween_property($Panel,"position:y",-225.0 + 100,0.5).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property($Panel,"modulate:a",0.0,0.5)
	await tween.finished
	start = true
	get_tree().paused = false
	offset = 576.0

func _process(delta: float) -> void:
	if tracking: 
		show()
		global_position.x = lerp(global_position.x, cam.global_position.x - offset,0.15)
		global_position.y = lerp(global_position.y,cam.global_position.y,0.1)
		if start: atktimer += delta
	else:
		global_position.x = cam.global_position.x - offset
		
	if moving:
		for rainbow in $trail.get_children():
			rainbow.position.x += 7
			if rainbow.position.x >= 125.0:
				rainbow.position.x = -1210.0
	if atktimer >= atktime:
		readyup()
		atktimer = 0.0

func tween():
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "global_position:x", global_position.x + 1912.0, 0.6)
	moving = false
	for i in range($trail.get_children().size()):
		tween.parallel().tween_property($trail.get_child($trail.get_children().size() - i - 1), "modulate:a", 0.0, 0.8).set_delay(i * 0.05)
	await tween.finished
	hide()
	global_position.x -= 1912.0
	moving = true
	for rainbow in $trail.get_children():
		rainbow.modulate.a = 1.0
		
func readyup():
	$mark.show()
	var tween2 = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	for i in range(2):
		tween2.tween_property($mark, "modulate:a", 1.0, 0.1)
		tween2.tween_property($mark, "modulate:a", 0.0, 0.1)
	await tween2.finished
	$mark.hide()
	tracking = false
	$path.show()
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	for i in range(3):
		tween.tween_property($path, "modulate:a", 1.0, 0.2)
		tween.tween_property($path, "modulate:a", 0.0, 0.2)
	await tween.finished
	$path.hide()
	await tween()
	tracking = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.die()

func die():
	start = false
	get_tree().paused = true
	$Panel.visible = true
	$Panel/Label.visible_ratio = 0.0
	$Panel.modulate.a = 0.0
	$Panel/Label.text = "~ Awwww u beat me.. I guess I'll always be a background character ~"
	$Panel.position.y += 100
	var tween = create_tween()
	tween.tween_property($Panel,"position:y",-225.0,0.5).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property($Panel,"modulate:a",1.0,0.5)
	tween.tween_property($Panel/Label,"visible_ratio",1.0,0.8)
	tween.tween_interval(3)
	tween.tween_property($Panel,"position:y",-225.0 + 100,0.5).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property($Panel,"modulate:a",0.0,0.5)
	tween.tween_property(self, "modulate:a", 0.0, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(self, "scale", Vector2(0.00001, 0.00001), 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(self, "rotation_degrees", 720.0, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	await tween.finished
	get_tree().paused = false
	global.nyancatboss_defeated = true
	queue_free()
