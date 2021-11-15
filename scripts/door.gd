extends StaticBody2D

export var is_door = true
var is_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = "___" if is_door else "═══"
	#open()

func get_is_open():
	return is_open

func open():
	if is_door and not is_open:
		$Label.text = ""
		$CollisionShape2D.position += Vector2(3*Global.tile_size,0)
		is_open=!is_open
		

func close():
	if is_door and is_open:
		$Label.text = "___"
		$CollisionShape2D.position -= Vector2(3*Global.tile_size,0)
		is_open=!is_open
