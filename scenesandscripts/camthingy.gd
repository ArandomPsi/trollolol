extends Area2D

@export var camzoom : float = 0.0
@export var limit1 : Vector2
@export var limit2 : Vector2

@onready var collisionshape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	var shape = collisionshape.shape as RectangleShape2D
	var size = shape.size * collisionshape.scale
	
	var half_size = size / 2.0
	var center = collisionshape.global_position
	
	limit1 = center - half_size
	limit2 = center + half_size
