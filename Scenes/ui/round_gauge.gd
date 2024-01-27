extends Node2D

@export var percentage = 0.5
@export var radius = 100
@export var width = 20
@export var track_color = Color(0, 0, 0, 0.5)
@export var progress_color = Color(0.0, 0.6, 0.6)
@export var end_color = Color(0.0, 0.8, 0.2)

var drawn_percentage = -1

const angle_delta_between_points = PI / 16
const start_angle = - PI / 2

func _ready():
	remove_child($placeholder)

func _process(_delta):
	if (percentage != drawn_percentage && percentage >= 0 && percentage <= 1):
		queue_redraw()
		drawn_percentage = percentage

func _draw():
	var center = Vector2(0, 0)
	
	# draw the track in background
	draw_percentage_arc(center, radius, width, 1, track_color)
	
	# draw above the progress arc
	var color = progress_color
	if (percentage >= 1):
		color = end_color 
	draw_percentage_arc(center, radius, width, percentage, color)
	
func draw_percentage_arc(center, r, w, p, color):
	var points = get_arc(
		center,
		r - w,
		r,
		start_angle,
		start_angle + p * PI * 2.0)
	draw_polygon(points, PackedColorArray([color]))

func get_arc(center, inner_radius, outter_radius, angle_from, angle_to):
	var outter_points = PackedVector2Array()
	var inner_points = PackedVector2Array()

	var nb_points = ceil(abs(angle_to - angle_from) / angle_delta_between_points);

	for i in range(nb_points):
		var circle_point = get_normalized_circle_point(angle_from + i * angle_delta_between_points)
		outter_points.push_back(center + circle_point * outter_radius)
		inner_points.push_back(center + circle_point * inner_radius)
	
	var last_point = get_normalized_circle_point(angle_to);
	outter_points.push_back(center + last_point * outter_radius)
	inner_points.push_back(center + last_point * inner_radius)
	
	inner_points.reverse()
	outter_points.append_array(inner_points)
	return outter_points

func get_normalized_circle_point(angle):
	return Vector2(cos(angle), sin(angle))
