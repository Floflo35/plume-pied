extends Node2D

@export var background_asset: PackedScene
@export var location = Vector2.ZERO
@export var speed = -1000


func _on_timer_timeout():
	print("ARBRE")
	var bg_asset = background_asset.instantiate()
	
