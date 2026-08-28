extends CharacterBody2D


const SPEED = 120.0

var lastonfloor : bool = false

var camtweenzoom : float = 1
var camtweenpos : Vector2

@export var respawnpos : Vector2

var freemove : bool = false

func _ready() -> void:
	$sprite.visible = false
	position = global.playerrespawnpos
	respawnpos = position
	$spawnpar.emitting = true
	
	var tween = create_tween()
	tween.tween_method(settransshaderprop,0.0,1.05,0.4).set_trans(Tween.TRANS_CUBIC)
	await $spawnpar.finished
	$sprite.visible = true
	$diepar.emitting = true
	

func _physics_process(delta: float) -> void:
	
	controls()
	
	velocity.x *= 0.87
	velocity.y += 2500 * delta
	
	
	
	anims()
	
	if $sprite.visible:
		move_and_slide()
	else:
		velocity = Vector2(0,0)
	
	if not lastonfloor == is_on_floor() and is_on_floor():
		$sprite.scale.y = 0.2
		print("yo")
	
	lastonfloor = is_on_floor()
	
	if not $camareadetect.has_overlapping_areas():
		$Camera2D.limit_left = -2000
		$Camera2D.limit_right = 10000000
		$Camera2D.limit_top = -10000000
		$Camera2D.limit_bottom = 550
	
	global.playerpos = global_position
	

func controls():
	if Input.is_action_just_pressed("reset"):
		set_process(false)
		global.you_have_been_trolled = true
		global.playerrespawnpos = Vector2(-1200,-200)
		die()
	if freemove:
		var movedir = Input.get_vector("left", "right", "up", "down")
		velocity += movedir * SPEED
		return
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
	die()

func die():
	diestayinpos()
	$spikedetector/CollisionShape2D.set_deferred("disabled", true)
	$diepar.emitting = true
	$sprite.visible = false
	await get_tree().create_timer(1.4).timeout
	var tween = create_tween()
	tween.tween_method(settransshaderprop,1.05,0.0,0.4).set_trans(Tween.TRANS_CUBIC)
	tween.tween_interval(0.6)
	await tween.finished
	
	get_tree().reload_current_scene()

func settransshaderprop(val:float):
	$hud/transition.material.set_shader_parameter("circle_size",val)

func diestayinpos():
	velocity = Vector2(0,0)
