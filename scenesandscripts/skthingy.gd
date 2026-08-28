extends ParallaxLayer

@export var followingnode : Node2D

#space effect
func _process(delta: float) -> void:
	var thingy  = max(0.0,  abs(followingnode.position.y + 17000) / 17000)
	modulate = lerp(modulate,Color(1,1,1) * thingy,0.1)
	
