extends Node2D

var t : float

var checked : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	t += delta
	if checked:
		$base2.position.x = lerp($base2.position.x,sin(t*8) * 30,0.2)
		$base3.position.x = lerp($base3.position.x,sin(t*8) * -30,0.2)
	else:
		$base2.position.x = 0
		$base3.position.x = 0
	
	scale = lerp(scale,Vector2(1,1),0.1)
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	global.playerrespawnpos = position
	checked = true
	scale.y = 0.2
	scale.x = 1.5
