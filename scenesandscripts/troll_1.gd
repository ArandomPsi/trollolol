extends Area2D

@export var speed : float = 0.8



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property($spike,"position:y",-1200,speed)
	await tween.finished
	queue_free()
