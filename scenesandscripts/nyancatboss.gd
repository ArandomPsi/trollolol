extends Node2D

var moving : bool = false

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	tween()

func _process(delta: float) -> void:
	if moving:
		for rainbow in $trail.get_children():
			rainbow.position.x += 7
			if rainbow.position.x >= 125.0:
				rainbow.position.x = -1210.0

func tween():
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position:x", 1306.0, 0.6)
	moving = false
	for i in range($trail.get_children().size()):
		tween.parallel().tween_property($trail.get_child($trail.get_children().size() - i - 1), "modulate:a", 0.0, 0.8).set_delay(i * 0.05)
	tween.tween_property(self, "position:x", 154.0, 0.8)
	await tween.finished
	moving = true
	for rainbow in $trail.get_children():
		rainbow.modulate.a = 1.0
	tween()
		
