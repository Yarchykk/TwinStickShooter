extends Node2D
class_name RotateShoot_Component


signal rotator_fired(bullet, position, direction)	 #signal event that passes a bullet that was shot as it's parameter 


@onready var spawn_locations: Node2D = $Spawn_Locations
@onready var rotated_attack_cooldown: Timer = $RotatedAttackCooldown

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var Bullet = PackedScene.new()


#const rotate_speed : int = 0
#const shoot_timer_wait_time : float = 0.0
#const spawn_point_count : int = 0
#const radius : int = 0


var rotate_speed : int = 20
var shoot_timer_wait_time : float = .2
var spawn_point_count : int = 5
var radius : int = 20


func _ready() -> void:
	# 2*PI is full circle
	# PI is half circle
	###########!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	#####!	Difference between burst and rotate shoot componenets is the step var
	###########!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	var step : float = 2 * PI / spawn_point_count	#find the angle between spawn points
	
	#create spawn points and set their potition&rotation 
	for i in range(spawn_point_count):
		var spawn_point : Node2D = Node2D.new() #spawn point is a new 2d node so that we can use it's potition and rotation information 
		var pos : Vector2 = Vector2(radius, 0).rotated(step * i) 
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		spawn_locations.add_child(spawn_point)
		
	rotated_attack_cooldown.wait_time = shoot_timer_wait_time
	rotated_attack_cooldown.start()


##!!!!!!!!!
##Add an initialize function that sets the rotated_attack_cooldown Timer to start, also add the ability to call rotate_shoot() like weapon.shoot()
##!!!!!!!!!


func _process(delta:float)->void:
	global_position = get_parent().global_position
	var new_rotation = self.rotation_degrees - rotate_speed * delta #rotation_degrees uses 360 degreee angle values over the PI angle values
	self.rotation_degrees = fmod(new_rotation, 360) #fmod makes sure rotation doesn't go above 360


func _on_rotated_shoot_timer_timeout() -> void:
	for s in spawn_locations.get_children():
		var bullet_instance = Bullet.instantiate()	#instanciate a new instance of a bullet
		var bullet_position = s.global_position
		var bullet_direction = Vector2(1,0).rotated(s.global_rotation)
		rotator_fired.emit(bullet_instance,bullet_position,bullet_direction)
		#GlobalSignals.bullet_fired.emit(bullet_instance,2, bullet_position, bullet_direction)


