extends CharacterBody2D
class_name Actor_Script

@export var r_shoot_component: RotateShoot_Component = null
@export var b_shoot_component: BurstShoot_Component = null


@onready var camera:Camera2D = $"../../Camera2D" #need to know where the player is at all time for the sprite to be rotated accordingly 
@onready var actor_sprite:Sprite2D = $Sprite2D
@onready var sprite_2d_2: Sprite2D = $Sprite2D2
@onready var sprite_2d_3: Sprite2D = $Sprite2D3
@onready var sprite_2d_4: Sprite2D = $Sprite2D4
@onready var sprite_2d_5: Sprite2D = $Sprite2D5
@onready var sprite_2d_6: Sprite2D = $Sprite2D6
@onready var sprite_2d_7: Sprite2D = $Sprite2D7


@onready var health_stat = $Health_Component
@onready var weapon_component :Weapon_Component= $Weapon_Component
@onready var team_component : Team_Component= $Team_Component as Team_Component
@onready var ai_component :AI_Component= $AI_Component as AI_Component


@export var actor_speed : int = 100


func _ready() -> void:
	weapon_component.weapon_fired.connect(self.enemy_fired)
	ai_component.initialize(self,weapon_component,get_team()) #what we're doing is saying it's ok for our enemy to know that we have a weapon
	if r_shoot_component:
		r_shoot_component.rotator_fired.connect(self.enemy_fired)
	if b_shoot_component:
		b_shoot_component.burst_fired.connect(self.enemy_fired)


func _process(delta: float) -> void:
	var sprite_offset :Vector2 = Vector2(0,-30)
	
	actor_sprite.position=self.position
	actor_sprite.rotation=camera.rotation
	sprite_2d_2.position=self.position+(sprite_offset.rotated(camera.rotation))
	sprite_2d_3.position=self.position + (sprite_offset*2).rotated(camera.rotation)
	sprite_2d_4.position=self.position + (sprite_offset*3).rotated(camera.rotation)
	sprite_2d_5.position=self.position + (sprite_offset*4).rotated(camera.rotation)
	sprite_2d_6.position=self.position + (sprite_offset*5).rotated(camera.rotation)
	sprite_2d_7.position=self.position + (sprite_offset*6).rotated(camera.rotation)
	
#handles rotating the actor towards the input location


func rotate_toward(location:Vector2):
	rotation = lerp(rotation,global_position.direction_to(location).angle(),0.1)


#somethin somethin 
func velocity_toward(location:Vector2) -> Vector2:
	return global_position.direction_to(location) * actor_speed


func has_reached_position(location:Vector2) -> bool:
	return global_position.distance_to(location) < 5


func get_team() -> int:
	return team_component.entity_team


func enemy_fired(bullet_instance:Bullet, location:Vector2, direction:Vector2):
	#!!!!!add a tag to designate it's an enemy bullet over player bullet
	GlobalSignals.bullet_fired.emit(bullet_instance, get_team(),location, direction)


func handle_hit():
	health_stat.health -= 20
	print("Enemy Hit",health_stat.health)
	if health_stat.health <= 0:
		queue_free()
		
