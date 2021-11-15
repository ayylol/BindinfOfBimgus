extends KinematicBody2D

const Projectile = preload('res://scenes/Projectile.tscn')

export var max_health := 5
export var character := ''

export var walk_cooldown := 0.2

export var shot_cooldown := 0.1
export var projectile_speed := 0.1
export var projectile_range := 20
export var projectile_damage := 1

var current_health : int

var _time_since_step: float
var _time_since_shot: float
var _directions := {
	"right": [Vector2.RIGHT,0],
	"left": [Vector2.LEFT,180],
	"up": [Vector2.UP,-90],
	"down": [Vector2.DOWN,90]
	}
			
onready var ray := $MovementRayCast
onready var projectile_start := $Node2D/Position2D
# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = character 
	current_health = max_health
	_time_since_step = walk_cooldown
	_time_since_shot = shot_cooldown

func move(dir):
	if _time_since_step>=walk_cooldown:
		ray.cast_to = _directions[dir][0] * Global.tile_size
		ray.force_raycast_update()
		if !ray.is_colliding():
			position += _directions[dir][0] * Global.tile_size
		else:
			print(ray.get_collider())
		_time_since_step = 0

func shoot(dir, is_friendly):
	$Node2D.rotation = deg2rad(_directions[dir][1])
	if _time_since_shot>=shot_cooldown:
		var projectile = Projectile.instance()
		projectile.setup(projectile_speed, projectile_damage, 
			projectile_range, _directions[dir][0], 
			projectile_start.global_position, is_friendly) 
		projectile.position=projectile_start.global_position
		get_parent().add_child(projectile)
		
		_time_since_shot = 0

func damage(damage_done):
	current_health-=damage_done
	$Label.add_color_override("font_color", Color(1.0,0.0,0.0))
	$DamageTimer.start()
	if current_health<=0:
		die()
		
func die():
	queue_free()


func _on_DamageTimer_timeout():
	$Label.add_color_override("font_color", Color(0.0,1.0,0.0))
