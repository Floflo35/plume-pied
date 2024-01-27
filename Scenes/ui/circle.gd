extends Node2D

@export var color = Color(1, 0.7, 0.04)
@export var radius = 100

var lastDrawnColor

const nb_points = 32

func _ready():
	remove_child($placeholder)

func _process(_delta):
	if lastDrawnColor != color:
		queue_redraw()
	
func _draw():
	var center = Vector2(0, 0)
	var points = get_arc(center)
	draw_polygon(points, PackedColorArray([color]))

func get_arc(center):
	var points = PackedVector2Array()

	for i in range(nb_points):
		var circle_point = get_normalized_circle_point(i * 2 * PI / nb_points)
		points.push_back(center + circle_point * radius)
	
	return points

func get_normalized_circle_point(angle):
	return Vector2(cos(angle), sin(angle))

