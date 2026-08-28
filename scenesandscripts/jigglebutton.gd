extends Button


var buttonscaley : float = 1.0

var alreadypressed : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	$Sprite2D.scale.y = buttonscaley * 0.293
	
	if is_hovered():
		buttonscaley = lerp(buttonscaley,1.5,0.2)
		print("yes")
	else:
		buttonscaley = lerp(buttonscaley,1.0,0.3)
	


func _on_mouse_exited() -> void:
	buttonscaley = 0.5


func _on_mouse_entered() -> void:
	buttonscaley = 2


func _on_pressed() -> void:
	pass # Replace with function body.
