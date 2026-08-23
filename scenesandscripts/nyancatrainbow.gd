extends Node2D

var queue : Array
var maxlength : int = 80

var nyancatvelocity : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	nyancatvelocity.y += 500 * delta
	
	$Sprite2D.position += nyancatvelocity * delta
	
	
	
	if $Sprite2D.position.y > 800:
		nyancatvelocity.y = - randi_range(500,1000)
		nyancatvelocity.x = randi_range(-900,900)
	
	if $Sprite2D.position.x < -200:
		$Sprite2D.position.x = -200
		nyancatvelocity.x *= -1
	
	if $Sprite2D.position.x > 1152 + 200:
		$Sprite2D.position.x = 1152 + 200
		nyancatvelocity.x *= -1
	
	$Sprite2D.rotation_degrees += nyancatvelocity.x * 0.008
	
	updateline()

func updateline():
	$Line2D.clear_points()
	queue.push_back($Sprite2D.position)
	for i in range(queue.size()):
		$Line2D.add_point(queue[i])
	if queue.size() > maxlength:
		queue.pop_front()
