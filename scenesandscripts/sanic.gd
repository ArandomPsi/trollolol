extends Node2D

@export_multiline var texts : PackedStringArray
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel.visible = false

func _process(delta: float) -> void:
	if position.x > global.playerpos.x:
		$Sprite2D.scale.x = -0.515
	else:
		$Sprite2D.scale.x = 0.515


func _on_area_2d_body_entered(body: Node2D) -> void:
	$Area2D.queue_free()
	body.nomove = true
	$Panel.visible = true
	$Panel.modulate.a = 0.0
	spawngary()
	for i in range(2):
		$Panel/Label.visible_ratio = 0.0
		$Panel/Label.text = texts[i]
		$Panel.position.y += 100
		var tween = create_tween()
		tween.tween_property($Panel,"position:y",-225.0,0.5).set_trans(Tween.TRANS_CUBIC)
		tween.parallel().tween_property($Panel,"modulate:a",1.0,0.5)
		tween.tween_property($Panel/Label,"visible_ratio",1.0,0.8)
		tween.tween_interval(3)
		tween.tween_property($Panel,"position:y",-225.0 + 100,0.5).set_trans(Tween.TRANS_CUBIC)
		tween.parallel().tween_property($Panel,"modulate:a",0.0,0.5)
		await tween.finished
		if i == 0:
			$cage.hide()
		elif i == 1:
			get_tree().change_scene_to_file("res://scenesandscripts/endscreen.tscn")


func spawngary():
	await get_tree().create_timer(3.8).timeout
	
	var b = preload("res://scenesandscripts/garity.tscn").instantiate()
	get_parent().add_child(b)
	b.position = position
