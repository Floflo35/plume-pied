extends Node2D

const levels = [
	"res://Scenes/level1.tscn",
	"res://Scenes/level2.tscn"
]

const plume_positions = [
	Vector2(548, 303),
	Vector2(960, 540),
]

var current_level_scene
var current_level = 1

func _ready():
	current_level_scene = $Level1
	GameLogic.level_changed.connect(level_changed)

func level_changed(level):
	if current_level == level:
		pass

	current_level = level
	var level_index = max(0, min(level - 1, levels.size()))
	
	var level_path = levels[level_index]
	call_deferred("_deferred_load_scene_level", level_path)
	
	var plume_position = plume_positions[level_index]
	$Plume.position = plume_position

func _deferred_load_scene_level(path):
	current_level_scene.free()
	var s = ResourceLoader.load(path)
	current_level_scene = s.instantiate()
	get_tree().root.add_child(current_level_scene)
	get_tree().current_scene = current_level_scene
