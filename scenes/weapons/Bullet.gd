#Area 
extends Area2D
class_name  Bullet


@export var speed : int = 25

@onready var lifetime : Timer = $KillTimer
@onready var bullet_fired: AudioStreamPlayer2D = $BulletFired
@onready var bullet_hit_something: AudioStreamPlayer2D = $BulletHitSomething
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


var direction := Vector2.ZERO
var team : int = -1


func _ready() -> void:
	bullet_fired.play()
	lifetime.start()
	
	bullet_hit_something.finished.connect(on_sfx_finished)


func _physics_process(delta: float) -> void:
	if direction != Vector2.ZERO: #only move is a direction has been specified 
		var velocity = direction * speed 
		global_position += velocity 


func set_direction(new_direction:Vector2):
	self.direction=new_direction
	rotation += direction.angle()


func _on_kill_timer_timeout() -> void:
	queue_free()
	#if i want to use obj pooling i would put that code here 
	#instead of just queuefreeing the bullets


func _on_body_entered(body) -> void:
	if body.has_method("handle_hit"):
		if body.has_method("get_team") and body.get_team() != team:
			body.handle_hit()
			bullet_hit_something.play()
			hide()
			 
			collision_shape_2d.set_deferred("disabled",true)
			#queue_free()


func on_sfx_finished() -> void:
	queue_free()
