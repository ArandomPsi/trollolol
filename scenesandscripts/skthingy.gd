extends ParallaxLayer

var ms : int = 0
var s : int = 0
var m : int = 0

@export var followingnode : Node2D

func _ready() -> void:
	for c in $"../../checkpoints".get_children():
		c.checkpoint_checked.connect(_save_time)
	ms = global.ms
	s = global.s
	m = global.m

#space effect
func _process(delta: float) -> void:
	var thingy  = max(0.0,  abs(followingnode.position.y + 17000) / 17000)
	modulate = lerp(modulate,Color(1,1,1) * thingy,0.1)
	


func _on_timer_timeout() -> void:
	ms += 1
	if ms >= 100:
		ms = 0
		s += 1
	if s >= 60:
		s = 0
		m += 1
	var st = str(s) if s >= 10 else "0" + str(s)
	var mt = str(m) if m >= 10 else "0" + str(m)
	$"../timer".text = mt + ":" + st + "." + str(ms)

func _save_time():
	global.ms = ms
	global.s = s
	global.m = m
