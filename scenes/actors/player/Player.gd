extends CharacterBody2D
class_name Player


#Character Controls
@export_group("Character Controls")
@export var movement_speed := 300 				##Player Movement Speed in px per second 

#@onready var actor_sprite : Sprite2D = $Sprite2D
#@onready var health_stat = $Health_Component
@onready var team_component :Team_Component = $Team_Component
@onready var weapon_component :Weapon_Component= $Weapon_Component
#@onready var camera_2d : Camera2D = $"../Camera2D" #get the file path to the cameawdsawdsara obj


func _ready() -> void:
	init_signals()

func _process(delta: float) -> void:
	pass	


func _physics_process(delta:float) -> void:
	
	#Move Code
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * movement_speed
	move_and_slide()
	
	#Shoot Code
	#aweapon_component.look_at(get_global_mouse_position()) #make weapon look at mouse position, 
	if Input.is_action_pressed("shot"):
		weapon_component.shoot()


# Built in function, is not called every frame
# Func is called when an InputEvent happens and it gets to the player where nothing has handeled the input yet 
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):		   #Exit application on triggering InputMap 'exit' key ('esc')
		get_tree().quit()
	if event.is_action_pressed("reset_scene"): #Restart current scene on triggering InputMap 'reset_scene' key ('r')
		get_tree().reload_current_scene()
	

func get_team() -> int: 
	return team_component.entity_team
	

# Add a team tag to designate bullet's team (enemy vs player)
# Update shoot direction to be in the direction of the mouse cursor
func player_shot(bullet_instance:Bullet, location:Vector2, direction:Vector2) -> void:
	#get the location of where we want the bullet to go 
	var target : Vector2 = get_global_mouse_position()
	direction = self.global_position.direction_to(target).normalized()
	#Emit signal 
	GlobalSignals.bullet_fired.emit(bullet_instance, get_team(), location, direction)

func handle_hit() -> void:
	#health_stat.health -= 20
	#print("Player Hit",health_stat.health)
	#if health_stat.health <=0:
		##queue_free()
		pass
#		

func init_signals() -> void:
	weapon_component.weapon_fired.connect(self.player_shot) ##connect weapon component's 'weapon fired' signal to self.player shot func 
	#player.player_fired_bullet.connect(bullet_manager.handle_bullet_spawned) 
