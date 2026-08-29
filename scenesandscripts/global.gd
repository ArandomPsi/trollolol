extends Node
var playerpos : Vector2
var playerrespawnpos : Vector2 = Vector2(18939.0,-5912.0) #Vector2(15331.0, -4907.0)#Vector2(13615.0, -136.0)#Vector2(-1200,-200) #Vector2(18939.0,-5912.0)
var you_have_been_trolled : bool = false

func _ready() -> void:
	randomize()
