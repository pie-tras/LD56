extends Node2D

@export var level = "res://scene/main_level.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func switch_scene():
	get_tree().change_scene_to_file(level)

func _on_interact_area_body_entered(body: Node2D) -> void:
	if body == Global.player:
		call_deferred("switch_scene")
