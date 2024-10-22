extends Node2D

var running = false
const SUN_NUM = 0
const sun_scene = preload("res://sun.tscn")
var sun_list = []
var sun_copy_list = []
var DEFAULT_VELOCITY = 3
var planet_counter = 0
var start_vec = Vector2(0,0)
var can_spawn = true


func _input(event):
	
	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed():
		start_vec = event.position
		
	if event is InputEventMouseButton and event.button_index == 1 and event.is_released() and can_spawn:
		
		
		print("Mouse position: ", event.position)
		var sun_instance = sun_scene.instantiate()
		
		var init_magnitude = start_vec.distance_to(event.position) * 2
		var direction = event.position.angle_to_point(start_vec)
		
		sun_instance.velocity.x +=  abs(init_magnitude)*cos(direction)
		sun_instance.velocity.y +=  abs(init_magnitude)*sin(direction)
		
		
		sun_instance.position = event.position
		sun_instance.id = planet_counter
		planet_counter += 1
		add_child(sun_instance)
		
		sun_list.append(sun_instance)
		
		

func _process(delta):
	

	if running:
		
		sun_copy_list = []
		for sun in sun_list:
			sun_copy_list.append(sun.duplicate())
			
		for sun in sun_list:
			gravity(sun, delta)
				
				
			


func gravity(sun, delta):
	
	var collided = false
	var force = Vector2	(0,0)
	
	for other_sun in sun_copy_list:
		
		if sun.id == other_sun.id:
			continue
		var distance = sun.position.distance_to(other_sun.position)
		
		
		
		var magnitude = ((sun.mass * other_sun.mass) / pow(distance,2))
		var direction = sun.position.angle_to_point(other_sun.position)
		
		sun.velocity.x +=  abs(magnitude)*cos(direction)
		sun.velocity.y +=  abs(magnitude)*sin(direction)
		
		if sun.position.distance_to(other_sun.position) <= (other_sun.radius):
			
			for real_other_sun in sun_list:
				if real_other_sun.id == other_sun.id:
					real_other_sun.queue_free()
					sun_list.erase(real_other_sun)
			
			sun.queue_free()
			sun_list.erase(sun)
			
	sun.position += sun.velocity*delta


func _on_pause_button_down():
	running = false

func _on_start_button_up():
	running = true
	



func _on_pause_mouse_entered():
	can_spawn = false # Replace with function body.

func _on_start_mouse_entered():
	can_spawn = false


func _on_start_mouse_exited():
	can_spawn = true # Replace with function body.


func _on_pause_mouse_exited():
	can_spawn = true # Replace with function body.


func _on_clear_button_up():
	for sun in sun_list:
		sun.queue_free()
	sun_list = [] # Replace with function body.
