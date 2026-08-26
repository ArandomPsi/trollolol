extends Area2D

@export var speed : float = 0.8
@export var target_y : float = -1200.0
@export var freeable : bool = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property($spike,"position:y",target_y,speed)
	await tween.finished
	if freeable: queue_free()
