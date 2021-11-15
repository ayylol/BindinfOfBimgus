extends "res://scripts/actor.gd"

signal changed_rooms

func _physics_process(delta):
	_time_since_step += delta
	_time_since_shot += delta
	for dir in _directions.keys():
			if Input.is_action_pressed(dir):
				move(dir)
			if Input.is_action_pressed("atk_"+dir):
				shoot(dir, true)

func entered_new_room(room_position):
	emit_signal("changed_rooms", room_position)
