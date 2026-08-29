extends Node2D

@export_multiline var texts : PackedStringArray
@export var platforms : Array[Node2D]
@export var speed : float = 3.0
var min_platform_pos : Array
var active_platform : bool = false
var time : float
@export var reversed : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel.visible = false
	if not platforms.is_empty():
		for p in platforms:
			min_platform_pos.append(p.global_position.y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var remap = remap(position.distance_to(global.playerpos), 0, 756, 0, 0.385)
	if position.x > global.playerpos.x:
		$Sprite2D.scale.x = remap
		$Sprite2D.scale.x = max($Sprite2D.scale.x, 0.18)
	else:
		$Sprite2D.scale.x = -remap
		$Sprite2D.scale.x = min($Sprite2D.scale.x, -0.18)
	if active_platform and not platforms.is_empty():
		for i in range(platforms.size()):
			var m = 1 if not reversed else -1
			platforms[i].rotation_degrees += m * speed


func _on_area_2d_body_entered(body: Node2D) -> void:
	$Area2D.queue_free()
	$Panel.visible = true
	$Panel.modulate.a = 0.0
	$Panel/Label.text = texts[randi_range(0, texts.size() - 1)]
	$Panel.position.y += 100
	var tween = create_tween()
	tween.tween_property($Panel,"position:y",-225.0,0.5).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property($Panel,"modulate:a",1.0,0.5)
	tween.tween_property($Panel/Label,"visible_ratio",1.0,0.8)
	tween.tween_interval(3)
	tween.tween_property($Panel,"position:y",-225.0 + 100,0.5).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property($Panel,"modulate:a",0.0,0.5)


func _on_platformmovearea_body_entered(body: Node2D) -> void:
	$platformmovearea.queue_free()
	active_platform = true
