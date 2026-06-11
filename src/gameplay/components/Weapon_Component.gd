extends Node2D
class_name Weapon_Component


signal weapon_fired(bullet, position, direction)	 #signal event that passes a bullet that was shot as it's parameter 
signal weapon_out_of_ammo


@export var Bullet = PackedScene.new()


@export var max_ammo : int = 999
var current_ammo : int = max_ammo
# TODO @export var damage : int = 1


@onready var shoot_location : Marker2D = $Shoot_Location #could be unused and just swap for player center point
@onready var shoot_direction: Marker2D = $Shoot_Direction #unused


@onready var attack_cooldown : Timer = $AttackCooldown
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var muzzle_flash : Sprite2D = $MuzzleFlash


func _ready() -> void:
	muzzle_flash.hide()


func shoot():
	if current_ammo >= 0 and attack_cooldown.is_stopped() and Bullet != null:
		var bullet_instance = Bullet.instantiate()	#instanciate a new instance of a bullet
		var direction : Vector2 = (shoot_direction.global_position - shoot_location.global_position)
		weapon_fired.emit(bullet_instance, shoot_location.global_position, direction)
		attack_cooldown.start()
		#animation_player.play("muzzle_flash") 
		current_ammo -= 1
		if current_ammo <=0:
			weapon_out_of_ammo.emit() 
		#!!!!!!!doesn't work well for playerr given that player shoot direction is indicitive of 
			#mouse position over shoot_direction marker 


func start_reload():
	animation_player.play("reload") #adding a tag to an animation frame. when animation frame is reached call the _stop_reload() func to reset ammo count
	#can also emit a signal from animation player on animation_finished 

func _stop_reload():
	current_ammo=max_ammo
