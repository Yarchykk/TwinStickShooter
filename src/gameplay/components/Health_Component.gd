extends Node2D

@export var health : int = 100:
	set = set_health#, get = get_health


#if another node tries to access health and set it, 
	#we can put handleing in the setter fucntion to make sure a valid value is set
func set_health(new_health:int): 
	health = clamp(new_health, 0, 100) #clamp health to be between min and max
	#emit signal, health changed 
