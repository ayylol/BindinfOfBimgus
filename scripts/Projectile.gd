extends Area2D 

var speed := 0.1
var damage := 1
var range_ := 5
var direction := Vector2(1,0)
var is_friendly := true

var _time_since_moved = 0
var _distance_moved = 0

func setup(speed_: float, damage_:int, range__: int, 
	direction_: Vector2, position_: Vector2, is_friendly_: bool):
		speed = speed_
		damage = damage_
		range_ = range__
		direction = direction_
		position = position_
		is_friendly=is_friendly_

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	_time_since_moved+=delta
	if(_time_since_moved>=speed and _distance_moved<range_):
		position += direction * Global.tile_size
		_time_since_moved=0
		_distance_moved+=1

	
	if _distance_moved == range_:
		queue_free()
	#warning-ignore:integer_division
	elif _distance_moved > range_/2:
		$Label.text = "•"
	#warning-ignore:integer_division
	elif _distance_moved > range_/3:
		$Label.text = "o"

func _on_Projectile_body_entered(body):
	if body.has_method("damage"):
		if (body.get_name() == "player") != is_friendly:
			body.damage(damage)
		else:
			return
	queue_free() # Replace with function body.
