extends Area2D

@export var speed : float = 0.8
@export var target_y : float = -1200.0
@export var freeable : bool = true
@export var random : bool = false
@export var tethered_troll : Node2D # if this one doesn't go, the other will activate
var active : bool = false

func _ready() -> void:
	if random:
		active = randi_range(0, 100) >= 50
		if not active and random:
			if tethered_troll != null:
				if tethered_troll is CollisionShape2D:
					tethered_troll.disabled = false
				else:
					tethered_troll.get_node("CollisionShape2D").disabled = false
		elif tethered_troll != null:
			if tethered_troll is CollisionShape2D:
					tethered_troll.disabled = true
			else:
				tethered_troll.get_node("CollisionShape2D").disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print(name, " READY | random=", random, " active=", active)
	if random:
		if not active:
			return
	var tween = create_tween()
	tween.tween_property($spike,"position:y",target_y,speed)
	await tween.finished
	if freeable: queue_free()
