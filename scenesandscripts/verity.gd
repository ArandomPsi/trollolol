extends Node2D

@export var text : String = "Gurney"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position.distance_to(global.playerpos) < 2000:
		$eyes.look_at(global.playerpos)
		$eyes/eyes.global_rotation = 0.0


func _on_area_2d_body_entered(body: Node2D) -> void:
	$Area2D.queue_free()
	$Panel.visible = true
	$Panel.modulate.a = 0.0
	$Panel/Label.text = text
	$Panel.position.y += 100
	var tween = create_tween()
	tween.tween_property($Panel,"position:y",-225.0,0.5).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property($Panel,"modulate:a",1.0,0.5)
	tween.tween_property($Panel/Label,"visible_ratio",1.0,0.8)
	tween.tween_interval(3)
	tween.tween_property($Panel,"position:y",-225.0 + 100,0.5).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property($Panel,"modulate:a",0.0,0.5)
