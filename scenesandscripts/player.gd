extends CharacterBody2D


const SPEED = 120.0

var lastonfloor : bool = false

var camtweenzoom : float = 1
var camtweenpos : Vector2

func _physics_process(delta: float) -> void:
	
	controls()
	
	velocity.x *= 0.87
	velocity.y += 2500 * delta
	
	
	
	anims()
	
	move_and_slide()
	
	if not lastonfloor == is_on_floor() and is_on_floor():
		$sprite.scale.y = 0.2
		print("yo")
	
	lastonfloor = is_on_floor()
	
	if not $camareadetect.has_overlapping_areas():
		$Camera2D.limit_left = -10000000
		$Camera2D.limit_right = 10000000
		$Camera2D.limit_top = -10000000
		$Camera2D.limit_bottom = 550
	
	global.playerpos = global_position
	

func controls():
	
	var movedirx = Input.get_axis("left","right")
	
	velocity.x += movedirx * SPEED
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -800
		$sprite.scale.y = 0.6
		$sprite.scale.x = 0.1
	
	
	

func anims():
	
	var state = "idle"
	
	var inputs = Input.get_axis("left","right")
	
	if not inputs == 0:
		state = "run"
	
	if not is_on_floor():
		state = "jump"
	
	$sprite.play(state)
	
	if inputs > 0 :
		$sprite.flip_h = false
	elif inputs < 0:
		$sprite.flip_h = true
	
	if not is_on_floor():
		var stretch = abs(velocity.y/100) / 10000000000000000 + 0.7
		
		$sprite.scale.y = lerp($sprite.scale.y, stretch, 0.1)
		
		$sprite.scale.x = lerp($sprite.scale.x,0.5,0.2)
	else:
		$sprite.scale = lerp($sprite.scale,Vector2(0.5,0.5),0.3)
		
	
	


func _on_camareadetect_area_entered(area: Area2D) -> void:
	$Camera2D.limit_left = area.limit1.x
	$Camera2D.limit_top = area.limit1.y
	$Camera2D.limit_right = area.limit2.x
	$Camera2D.limit_left = area.limit2.y


func _on_spikedetector_body_entered(body: Node2D) -> void:
	queue_free()
