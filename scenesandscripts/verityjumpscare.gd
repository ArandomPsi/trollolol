extends CanvasLayer

func _process(delta: float) -> void:
	$Sprite2D.rotation_degrees += randf_range(-25, 25)
	$Sprite2D.scale += Vector2.ONE * randf_range(-0.1, 0.1)
	$Sprite2D.rotation_degrees = lerpf($Sprite2D.rotation_degrees, 0.0, 20 * delta)
	$Sprite2D.scale = lerp($Sprite2D.scale, Vector2.ONE, 20 * delta)



func _on_audio_stream_player_finished() -> void:
	queue_free()
