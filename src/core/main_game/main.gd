extends Node2D

@onready var bullet_manager: Node2D = $Systems/BulletManager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#TODO quick fix to grab window focus on game launch in editor not working 
	# seems to maybe be a linux bug? 
	get_window().grab_focus()
	
	randomize() #change the random number seed 
	
	## Connect nessesary signals for level
	GlobalSignals.bullet_fired.connect(bullet_manager.handle_bullet_spawned) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
