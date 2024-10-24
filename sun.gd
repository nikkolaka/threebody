extends Node2D

var rng = RandomNumberGenerator.new()
var min_size = 1
var max_size = 2
var sprite_scale = 0.1
var sprite_offset = Vector2(400, 400)


@export var mass = 1
@export var id: int
@export var radius = rng.randi_range(min_size,max_size)
@export var velocity: Vector2 = Vector2(0,0)

func _ready():
	mass = (4/3)*PI*pow(radius, 3)

func _draw():
	draw_circle(Vector2(0,0), radius, Color.RED)
