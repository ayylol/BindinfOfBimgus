extends Node2D

var doors = []

export var room_cleared = false

func _ready():
	for door in $Doors.get_children():
		doors.push_back(door)
		door.open()

func _on_RoomBounds_body_entered(body):
	if body.get_name()=="player":
		body.entered_new_room(position)
		if(not room_cleared):
			for door in doors:
				door.close()
