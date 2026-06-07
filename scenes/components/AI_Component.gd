extends Node2D
class_name AI_Component

signal state_changed(new_state)


enum State{
	PATROL,
	ENGAGE,
	ADVANCE
}


@onready var patrol_timer : Timer = $PatrolTimer


var current_state:int = -1: #on initialization temp set the state to an unreachable value
	set = set_state
var actor: Actor_Script = null
var target:CharacterBody2D = null
var weapon_component:Weapon_Component = null
var team:int = -1

#PATROL STATE
var origin:Vector2 = Vector2.ZERO
var patrol_location:Vector2 = Vector2.ZERO
var patrol_location_reached:bool=false
var actor_velocity:Vector2 = Vector2.ZERO


#ADVANCE STATE
var next_base : Vector2 = Vector2.ZERO


func _ready() -> void:
	set_state(State.PATROL) #on initialization set_state to patroling 


func _physics_process(delta: float) -> void:
	match current_state:
		State.PATROL:
			if not patrol_location_reached:
				actor_velocity = actor.velocity_toward(patrol_location)
				actor.move_and_slide() 
				#not aplicable but i can make the actor rotation face the direction of where the actor is patroling to
				actor.rotate_toward(patrol_location)
				if actor.has_reached_position(patrol_location): #if distance to patrol_location is <5, set reached to true
					patrol_location_reached = true
					actor_velocity = Vector2.ZERO
					patrol_timer.start()
		State.ENGAGE:
			if target != null and weapon_component != null:
				actor.rotate_toward(target.global_position)
				var angle_to_target = actor.global_position.direction_to(target.global_position).angle()
				if abs(actor.rotation - angle_to_target)<0.1: #isn't fired until actor is nearly facing the player
					weapon_component.shoot()
			else:
				print("In the engage state but no weapon/target")
		State.ADVANCE:
			if actor.has_reached_position(next_base):
				set_state(State.PATROL)
			else: 
				actor_velocity = actor.velocity_toward(next_base)
				actor.move_and_slide() 
				#not aplicable but i can make the actor rotation face the direction of where the actor is patroling to
				actor.rotate_toward(patrol_location)
		_:
			print("Error: found state for enemy that shouldn't exist")


func initialize(actor:CharacterBody2D, weapon:Weapon_Component, team:int): #initialize is a good name to give functions revolved around dependency injection, think of it as an unofficial constructor 
	self.actor = actor
	self.weapon_component = weapon
	self.team = team
	weapon_component.weapon_out_of_ammo.connect(self.handle_reload) #https://youtu.be/YAoueKaqhkc?si=xp3Flqyx0DpWO6Hi&t=874 explaing why this is here 


func set_state(new_state:int):
	if new_state == current_state:
		return
	if new_state == State.PATROL:
		origin=global_position
		patrol_timer.start()
		patrol_location_reached=true
	
	elif new_state == State.ADVANCE:
		if actor.has_reached_position(next_base):
			set_state(State.PATROL)
	
	current_state = new_state
	state_changed.emit(current_state)


func get_new_target():
	pass


func handle_reload():
	weapon_component.start_reload()


func _on_patrol_timer_timeout() -> void:
	var patrol_range = 150 #range of how far the patrol distance should be 
	var random_x = randi_range(-patrol_range,patrol_range)
	var random_y = randi_range(-patrol_range,patrol_range)
	patrol_location=Vector2(random_x,random_y) + origin #patrol to random point within 50 units of origin 
	patrol_location_reached=false



func _on_detection_zone_body_entered(body: Node2D) -> void:
	if body.has_method("get_team") and body.get_team() != team:
		set_state(State.ENGAGE)
		target = body


func _on_detection_zone_body_exited(body: Node2D) -> void:
	if target and body == target: #if player has been detected previously, and body exited is the player 
		set_state(State.ADVANCE)
		target = null
