extends StaticBody2D

var doors = []

export var room_cleared = true

func _ready():
	doors.push_back($TopDoor)
	doors.push_back($BottomDoor)
	doors.push_back($LeftDoor)
	doors.push_back($RightDoor)
	
	#for door in $Doors.get_children():
	#	doors.push_back(door)
	#	door.open()
	
	for door in doors:
		door.open()

func _on_RoomBounds_body_entered(body):
	if body.get_name()=="player":
		body.entered_new_room(position)
		if(not room_cleared):
			for door in doors:
				door.close()
